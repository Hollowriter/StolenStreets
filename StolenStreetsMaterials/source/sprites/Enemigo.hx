package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.Golpe;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Enemigo extends FlxSprite{
	private var timer:Int; // timer de comportamiento (una AI de mierda)
	private var punios:Golpe; // golpe del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500; // gravedad
		makeGraphic(30, 30, FlxColor.GREEN);
		drag.x = 1000;
		punios = new Golpe(1000, 1000);
		direccion = false;
		timer = 0;
		isHurt = 0; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
	}
	// patron de comportamiento general del enemigo
	public function enemyMovement(objective:Jugador){
		if (isHurt == 0 && isTouching(FlxObject.FLOOR)){ // si no esta lastimado y esta en el piso
			if (direccion == false){
				velocity.x = Reg.hSpeed; // camina
				timer++; // cada segundo
				if (timer == 60){ // si su timer de comportamiento llega a este numero
					facing = FlxObject.RIGHT; // cambia de direccion
					direccion = true; // lo chequea
					timer = 0; // reinicia el timer
					punios.posicionar(); // y hace desaparecer si puñetazo (si golpeo)
				}
			}
			else if (direccion == true){ // misma historia aca pero hacia la otra direccion
				velocity.x = Reg.hSpeed * (-1);
				timer++;
				if (timer == 60){
					facing = FlxObject.LEFT;
					direccion = false;
					timer = 0;
					punios.posicionar();
				}
			}
		}
	}
	// getter de su golpe
	public function getPunch(){
		return punios;
	}
	// esto convierte sus puños en un ataque
	public function atacar(){
		if (alive && isHurt == 0 && isTouching(FlxObject.FLOOR)){ // mientras este vivo/exista, no este lastimado y no toque el piso
			if (timer >= 50){ // y su patron de comportamiento sea mayor o igual a este numero
				velocity.x = 0; // se detendra
				punios.niapiDos(this, direccion); // y dara un golpe
			}
		}
	}
	// comportamiento de dolor del enemigo ante un golpe
	public function thyPain(agresor:Jugador){
		if (isHurt == 1){ // si esta lastimado normalmente
			timer++; // tiempo de recuperacion
			punios.posicionar(); // elimina el ataque del enemigo
			if (timer > Reg.effectTimer){ // si es mayor el timer que este numero
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
		}
		else if (isHurt == 2){ // si esta lastimado por un golpe duro
			timer++; // tiempo de recuperacion
			punios.posicionar(); // elimina el ataque del enemigo
			/* el enemigo es empujado al aire */
			if (timer <= Reg.effectTimer){ // sale volando
				velocity.y = Reg.vSpeed;
			}
			else if (timer >= Reg.effectTimer){ // y luego cae
				velocity.y = Reg.vSpeed * (-1);
			}
			if (agresor.getDireccion() == true){ // empujado segun la posicion del jugador
				velocity.x = Reg.hSpeed * ( -5);
			}
			else if (agresor.getDireccion() == false){ // empujando segun la posicion del jugador
				velocity.x = Reg.hSpeed * 5;
			}
			if (timer > (Reg.effectTimer + Reg.effectTimer) && isTouching(FlxObject.FLOOR)){ // si es mayor el timer que este numero y esta tocando el piso
				isHurt = 0; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
		}
	}
	// setter del dolor del enemigo
	public function setHurt(hurted:UInt){
		isHurt = hurted;
	}
	// retorna si el enemigo esta lastimado
	public function getHurt(){
		return isHurt;
	}
	// setter y getter del timer de comportamiento
	public function setTimer(forThyTimer:Int){
		timer = forThyTimer;
	}
	public function getTimer(){
		return timer;
	}
	// setter y getter de la direccion del enemigo
	public function setDireccion(mirando:Bool){
		mirando = direccion;
	}
	public function getDireccion(){
		return direccion;
	}
	// reformulacion comentada
	/*override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// atacar(); (Descomentar aca y comentar en playstate)
	}*/	
}