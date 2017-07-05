package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.ds.IntMap;
import sprites.GolpeEnemigo;
import flixel.FlxObject;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author MicaelaPereyra
 */
class BaseEnemigo extends FlxSprite 
{
	private var vidaEnemiga:Int; // vida del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var punioEnemigo:GolpeEnemigo; // nuevo golpe del enemigo
	
	private var enemyRightMin:Float;
	private var timer:Int;
	private var comboTimer:Int;
	public var enemyRightMax:Float;
	public var enemyLeftMin:Float;
	public var enemyLeftMax:Float;
	

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		punioEnemigo = new GolpeEnemigo(1000, 1000);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		
		enemyRightMin = Reg.posXjugador;
		enemyRightMax = Reg.posXjugador - (Reg.widthJugador * 2);
		enemyLeftMin = Reg.posXjugador;
		enemyLeftMax = Reg.posXjugador + (Reg.widthJugador * 2);
		EnElAire();
		Morir();
		if(x < (Reg.posXjugador + 600) || x > (Reg.posXjugador - 600)) {move();}
	}
	public function move(){};
	public function gotHitted(){};
	public function EnElAire(){
		if (isTouching(FlxObject.FLOOR) || isTouching(FlxObject.ANY)){
			saltito = false;
		}
		else{
			saltito = true;
		}
	}
	public function DolorDelEnemigo(agresor:Jugador){
		if (isHurt == 1 || agresor.GetAgarrando() == true){ // si esta lastimado normalmente
			timer++; // tiempo de recuperacion
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
			if (agresor.GetAgarrando() == true){ // Si el jugador lo esta agarrando, el isHurt no hace falta para matenerlo quieto
				isHurt = 0;// Ademas, si el isHurt se queda en 1 mientras lo agarra, no podes golpearlo
			}
			if (timer > Reg.effectTimer && agresor.GetAgarrando() == false){ // si es mayor el timer que este numero y no es un agarre
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
			else if (timer > Reg.effectTimer + 100 && agresor.GetAgarrando() == true){ // esto es lo que hace que el enemigo se escape del agarre
				isHurt = 0; // esto esta por las dudas
				timer = 0; // setea el timer a cero
				agresor.SetAgarrando(false); // y se libera del agarre
			} // dura mas tiempo y setea el agarre a false cuando se acaba
		}
		else if (isHurt == 2){ // si esta lastimado por un golpe duro
			timer++; // tiempo de recuperacion
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
			/* el enemigo es empujado al aire */
			if (timer <= Reg.effectTimer){ // sale volando
				velocity.y = Reg.vSpeed;
			}
			else if (timer >= Reg.effectTimer){ // y luego cae
				velocity.y = Reg.vSpeed * (-1);
			}
			if (agresor.GetDireccion() == true){ // empujado segun la posicion del jugador
				velocity.x = Reg.EnemigoVelocidadVuelo * ( -5);
			}
			else if (agresor.GetDireccion() == false){ // empujando segun la posicion del jugador
				velocity.x = Reg.EnemigoVelocidadVuelo * 5;
			}
			if (timer > (Reg.effectTimer + Reg.effectTimer) || saltito == false){ // si es mayor el timer que este numero y esta tocando el piso
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
				velocity.y = 0; // esto es para evitar que se vaya al carajo cuando sale volando
				velocity.x = 0; // esto es para evitar que se vaya al carajo cuando sale volando
			}
		}
	}
	private function Morir(){
		if (vidaEnemiga <= 0){
			kill();
		}
	}
	public function SetVida(health:Int){
		vidaEnemiga = health;
	}
	public function GetVida(){
		return vidaEnemiga;
	}
	// setter del dolor del enemigo
	public function SetHurt(hurted:UInt){
		isHurt = hurted;
	}
	// retorna si el enemigo esta lastimado
	public function GetHurt(){
		return isHurt;
	}
	// setter y getter del timer de comportamiento
	public function SetTimer(forThyTimer:Int){
		timer = forThyTimer;
	}
	public function GetTimer(){
		return timer;
	}
	// setter y getter de la direccion del enemigo
	public function SetDireccion(mirando:Bool){
		mirando = direccion;
	}
	public function GetDireccion(){
		return direccion;
	}
	public function GetGolpeEnemigo():GolpeEnemigo{
		return punioEnemigo;
	}
}