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
	private var isHurt:Bool; // chequea si recibio un golpe
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500; // gravedad
		makeGraphic(30, 30, FlxColor.GREEN);
		drag.x = 1000;
		punios = new Golpe(1000, 1000);
		direccion = false;
		timer = 0;
		isHurt = false;
	}
	// patron de comportamiento general del enemigo
	public function enemyMovement(objective:Jugador){
		if (isHurt == false && isTouching(FlxObject.FLOOR)){ // si no esta lastimado y esta en el piso
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
		else if (isHurt == true){ // si esta lastimado
			timer++; // tiempo de recuperacion
			punios.posicionar(); // elimina el ataque del enemigo
			if (timer > Reg.effectTimer){ // si es mayor el timer que este numero
				isHurt = false; // el enemigo se recupera
				timer = 0; // y se reinicia su timer de comportamiento
			}
		}
	}
	// getter de su golpe
	public function getPunch(){
		return punios;
	}
	// esto convierte sus puños en un ataque
	public function atacar(){
		if (alive && isHurt == false && isTouching(FlxObject.FLOOR)){ // mientras este vivo/exista, no este lastimado y no toque el piso
			if (timer >= 50){ // y su patron de comportamiento sea mayor o igual a este numero
				velocity.x = 0; // se detendra
				punios.niapiDos(this, direccion); // y dara un golpe
			}
		}
	}
	// setter switch del dolor del enemigo
	public function setHurt(hurted:Bool){
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
}