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
	private var isHurt:EstadoEnemigo; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var punioEnemigo:GolpeEnemigo; // nuevo golpe del enemigo
	private var anchuraObjeto:Int = 30;
	private var alturaObjeto:Int = 30;
	private var guia:GuiaEnemigo;
	private var enemyRightMin:Float;
	private var timer:Int;
	private var comboTimer:Int;
	private var muerto:Bool;
	public var enemyRightMax:Float;
	public var enemyLeftMin:Float;
	public var enemyLeftMax:Float;
	public var enemyUpper:Float;
	private var animacionEmpezo:Bool;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = Reg.gravedad;
		// offset.set(hitboxPosX, hitboxPosY); //traslada el hitbox //AFECTA A LA POSICION DE LOS GOLPES
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		guia = new GuiaEnemigo(x, y);
		animacionEmpezo = false;
	}
	public function move(){};
	public function gotHitted(){};
	public function EnElAire(){
		/*if (isTouching(FlxObject.FLOOR) || isTouching(FlxObject.ANY)){
			saltito = false;
		}
		else{
			saltito = true;
		}*/
	}
	public function DolorDelEnemigo(agresor:Jugador){
		if (isHurt == source.EstadoEnemigo.Lastimado){ // si esta lastimado normalmente
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
			/*if (timer > Reg.effectTimer && isHurt != source.EstadoEnemigo.Agarrado){ // si es mayor el timer que este numero y no es un agarre
				isHurt = source.EstadoEnemigo.Normal; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}*/
			/*else if (timer > Reg.effectTimer + 100 && isHurt == source.EstadoEnemigo.Agarrado){ // esto es lo que hace que el enemigo se escape del agarre
				isHurt = source.EstadoEnemigo.Normal; // esto esta por las dudas
				timer = 0; // setea el timer a cero
				// agresor.SetAgarrando(false); // y se libera del agarre
			}*/ // dura mas tiempo y setea el agarre a false cuando se acaba
		} // esta cosa con timer hacia OP a mili
		else if (isHurt == source.EstadoEnemigo.Lanzado){ // si esta lastimado por un golpe duro
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
			/* el enemigo es empujado al aire */
			/*if (timer <= Reg.effectTimer){ // sale volando
				velocity.y = Reg.vSpeed;
			}*/
			/*else if (timer >= Reg.effectTimer){ // y luego cae
				velocity.y = Reg.vSpeed * (-1);
			}*/
			/*if (agresor.GetDireccion() == true){ // empujado segun la posicion del jugador
				velocity.x = Reg.EnemigoVelocidadVuelo * ( -5);
			}*/
			/*else if (agresor.GetDireccion() == false){ // empujando segun la posicion del jugador
				velocity.x = Reg.EnemigoVelocidadVuelo * 5;
			}*/
			/*if (timer > (Reg.effectTimer + Reg.effectTimer) || saltito == false){ // si es mayor el timer que este numero y esta tocando el piso
				isHurt = source.EstadoEnemigo.Normal; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
				velocity.y = 0; // esto es para evitar que se vaya al carajo cuando sale volando
				velocity.x = 0; // esto es para evitar que se vaya al carajo cuando sale volando
			}*/
		}
	}
	public function Morir():Void{}
	public function SetVida(health:Int){
		vidaEnemiga = health;
	}
	public function GetVida(){
		return vidaEnemiga;
	}
	// setter del dolor del enemigo
	public function SetHurt(hurted:EstadoEnemigo){
		isHurt = hurted;
	}
	// retorna si el enemigo esta lastimado
	public function GetHurt():EstadoEnemigo{
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
	public function SetSaltito(salto:Bool){
		saltito = salto;
	}
	public function GetSaltito():Bool{
		return saltito;
	}
	public function GetGuia():GuiaEnemigo{
		return guia;
	}
	public function SetMuerto(moribundo:Bool){
		muerto = moribundo;
	}
	public function GetMuerto():Bool{
		return muerto;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (muerto == false){
			enemyRightMin = Reg.posXjugador;
			enemyRightMax = Reg.posXjugador - (Reg.widthJugador * 2);
			enemyLeftMin = Reg.posXjugador;
			enemyLeftMax = Reg.posXjugador + (Reg.widthJugador * 2);
			enemyUpper = Reg.posYjugador;
			//EnElAire();
		/*if(x < (Reg.posXjugador + Reg.elNumeroMagicoDeMica) || x > (Reg.posXjugador - Reg.elNumeroMagicoDeMica)) {move();}*/
		}
	}
}