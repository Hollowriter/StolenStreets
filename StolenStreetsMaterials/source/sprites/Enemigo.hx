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
	private var timer:Int;
	private var punios:Golpe;
	private var direccion:Bool;
	private var isHurt:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		makeGraphic(30, 30, FlxColor.GREEN);
		drag.x = 1000;
		punios = new Golpe(1000, 1000);
		direccion = false;
		timer = 0;
		isHurt = false;
	}
	public function enemyMovement(objective:Jugador){
		if (isHurt == false){
			if (direccion == false){
				velocity.x = Reg.hSpeed;
				timer++;
				if (timer == 60){
					facing = FlxObject.RIGHT;
					direccion = true;
					timer = 0;
					punios.posicionar();
				}
			}
			else if (direccion == true){
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
		else{
			if (objective.getCombo() > 2){
				trace("done it");
				objective.setCombo(0);
				timer = 0;
				if (objective.getDireccion() == true){
					while (timer <= Reg.effectTimer){
						velocity.x = Reg.hSpeed;
						velocity.y = Reg.vSpeed / ( -10);
						timer++;
					}
				}
				else{
					while (timer <= Reg.effectTimer){
						velocity.x = Reg.hSpeed * ( -1);
						velocity.y = Reg.vSpeed / ( -10);
						timer++;
					}
				}
				timer = 0;
			}
			if (isTouching(FlxObject.FLOOR)){
				velocity.x = 0;
				velocity.y = 0;
				timer++;
				if (timer >= Reg.effectTimer){
					isHurt = false;
					timer = 0;
				}
			}
		}
	}
	public function getPunch(){
		return punios;
	}
	public function atacar(){
		if (alive){
			if (timer >= 50){
				velocity.x = 0;
				punios.niapiDos(this, direccion);
			}
		}
	}
	public function setHurt(){
		if (isHurt == true){
			isHurt = false;
		}
		else{
			isHurt = true;
		}
	}
	public function getHurt(){
		return isHurt;
	}
	public function setTimer(forThyTimer:Int){
		timer = forThyTimer;
	}
	public function getTimer(){
		return timer;
	}
}