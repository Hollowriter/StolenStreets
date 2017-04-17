package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Enemigo extends FlxSprite{ // Clase Dummy
	private var timer:Int; // timer de comportamiento (una AI de mierda)
	private var vidaEnemiga:Int; // vida del enemigo
	// private var punios:Golpejugador; // ELIMINADO
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var puniosEnemigo:GolpeEnemigo; // nuevo golpe del enemigo
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500; // gravedad
		makeGraphic(30, 30, FlxColor.GREEN);
		drag.x = 1000;
		// punios = new Golpejugador(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios); // ELMINADO
		direccion = false;
		timer = 0;
		isHurt = 0; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
		saltito = false;
		vidaEnemiga = 30;
		puniosEnemigo = new GolpeEnemigo(1000, 1000); // nuevo golpe del enemigo
	}
	// patron de comportamiento general del enemigo
	public function MovimientoDelEnemigo(objective:Jugador){
		if (isHurt == 0 && saltito == false){ // si no esta lastimado y esta en el piso
			if (direccion == false){
				if (timer < 50){ // para coordinar con el ataque
					velocity.x = Reg.hSpeedEnemigo; // camina
				}
				timer++; // cada segundo
				if (timer == 60){ // si su timer de comportamiento llega a este numero
					facing = FlxObject.RIGHT; // cambia de direccion
					direccion = true; // lo chequea
					timer = 0; // reinicia el timer
					puniosEnemigo.PosicionarGE(); // y hace desaparecer si puñetazo (si golpeo)
				}
			}
			else if (direccion == true){ // misma historia aca pero hacia la otra direccion
				if (timer < 50){
					velocity.x = Reg.hSpeedEnemigo * ( -1);
				}
				timer++;
				if (timer == 60){
					facing = FlxObject.LEFT;
					direccion = false;
					timer = 0;
					puniosEnemigo.PosicionarGE();
				}
			}
		}
	}
	// getter de su golpe
	public function GetGolpeEnemigo(){
		return puniosEnemigo;
	}
	// esto convierte sus puños en un ataque
	public function Atacar(){
		if (alive && isHurt == 0 && saltito == false){ // mientras este vivo/exista, no este lastimado y no toque el piso
			if (timer >= 50){ // y su patron de comportamiento sea mayor o igual a este numero
				velocity.x = 0; // se detendra
				puniosEnemigo.PunietazoEnemigo(this, direccion); // y dara un golpe
			}
		}
	}
	// comportamiento de dolor del enemigo ante un golpe
	public function DolorDelEnemigo(agresor:Jugador){
		if (isHurt == 1){ // si esta lastimado normalmente
			timer++; // tiempo de recuperacion
			puniosEnemigo.PosicionarGE(); // elimina el ataque del enemigo
			if (timer > Reg.effectTimer){ // si es mayor el timer que este numero
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
		}
		else if (isHurt == 2){ // si esta lastimado por un golpe duro
			timer++; // tiempo de recuperacion
			puniosEnemigo.PosicionarGE(); // elimina el ataque del enemigo
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
			if (timer > (Reg.effectTimer + Reg.effectTimer) && saltito == false){ // si es mayor el timer que este numero y esta tocando el piso
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
		}
	}
	// setter y getter de la vida del enemigo
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
	// determina si esta en el aire
	public function EnElAire(){
		if (isTouching(FlxObject.FLOOR)){
			saltito = false;
		}
		else{
			saltito = true;
		}
	}
	// mata al enemigo
	private function Morir(){
		if (vidaEnemiga <= 0){
			kill();
		}
	}
	// reformulacion comentada
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		Atacar();
		Morir();
	}
}