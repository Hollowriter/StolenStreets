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
class Jugador extends FlxSprite{
	private var punios:Golpe;
	private var direccion:Bool;
	private var check:Bool;
	private var jump:Bool;
	private var time:Int;
	private var thyHits:Int;
	private var comboActivation:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		makeGraphic(30, 30, FlxColor.PINK);
		drag.x = 1000;
		punios = new Golpe(1000, 1000);
		direccion = false;
		check = false;
		time = 0;
		thyHits = 0;
		comboActivation = false;
		jump = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (x <= FlxG.camera.scroll.x + 5)
			x = FlxG.camera.scroll.x + 5;
		if (x + width >= FlxG.camera.scroll.x + FlxG.camera.width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y <= 5)
			y = 5;
		if (y + height >= FlxG.height)
			y = FlxG.height - height;
	}
	public function playerMovement():Void{
		if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}
		if (FlxG.keys.pressed.D && check==false){
			velocity.x += Reg.hSpeed;
			facing = FlxObject.RIGHT;
			direccion = false;
		}
	    if (FlxG.keys.pressed.A && check==false){
			velocity.x -= Reg.hSpeed;
			facing = FlxObject.LEFT;
			direccion = true;
		}
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR) && check==false)
			velocity.y = Reg.vSpeed;
		if (velocity.x >= Reg.maxhSpeed)
			velocity.x = Reg.maxhSpeed;
		if (velocity.x <= -Reg.maxhSpeed)
			velocity.x = -Reg.maxhSpeed;
	}
	public function getGolpear(){
		return punios;
	}
	public function golpear():Void{
		if (FlxG.keys.justPressed.J && check == false){
			check = true;
			if (jump == false){
				comboActivation = true;
			}
			time = 0;
		}
		if (check == true){
			punios.niapi(this, direccion, jump);
			if (jump == false){
				velocity.x = 0;
				velocity.y = 0;
			}
			else{
				if (FlxG.keys.pressed.D){
					velocity.x += Reg.hSpeed;
				}
				else if (FlxG.keys.pressed.A){
					velocity.x -= Reg.hSpeed;
				}
			}
		}
		if (time > 5){
			punios.posicionar();
			check = false;
		}
		if (check == true && comboActivation == false && isTouching(FlxObject.FLOOR)){
			punios.posicionar();
			check = false;
		}
		if (comboActivation == true){
			time++;
		}
	}
	public function combo():Void{
		if (FlxG.keys.justPressed.J && jump == false){
			thyHits++;
		}
		if (time > Reg.effectTimer || jump == true){
			thyHits = 0;
			time = 0;
			comboActivation = false;
		}
		if (thyHits > 3){
			thyHits = 0;
		}
	}
	public function getDireccion(){
		return direccion;
	}
	public function setDireccion(esto:Bool){
		direccion = esto;
	}
	public function getCombo(){
		return thyHits;
	}
	public function setCombo(comboMaster:Int){
		thyHits = comboMaster;
	}
}