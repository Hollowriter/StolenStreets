package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Golpe extends FlxSprite{
	// private var Time:Int;
	private var YouundMe:Bool;
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(11, 11, FlxColor.RED);
		// Reg.golpesGroup.add.(this);
		// Time = 0;
		YouundMe = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
	public function posicionar():Void{
		x = 1000;
		y = 1000;
	}
	public function niapi(?personaje:Jugador = null, mirando:Bool, saltando:Bool):Void{ // Pendiente de testear
		if (personaje != null){
			YouundMe = true;
			y = personaje.y;
			if (mirando == false){
				x = personaje.x + 25;
			}
			else if (mirando == true){
				x = personaje.x - 5;
			}
			if (saltando == true){
				y = personaje.y + 10;
			}
		}
	}
	public function niapiDos(?atacante:Enemigo = null, observando:Bool):Void{
		if (atacante != null){
			YouundMe = false;
			y = atacante.y;
			if (observando == false){
				x = atacante.x + 25;
			}
			else if (observando == true){
				x = atacante.x - 5;
			}
		}
	}
	public function zasEnTodaLaBoca(Ouch:Jugador, Pum:Enemigo):Void{
		if (overlaps(Pum) && YouundMe == true){
			posicionar();
			if (Pum.getHurt() == false){
				Pum.setHurt();
				Pum.setTimer(0);
			}
		}
		else if (overlaps(Ouch) && YouundMe == false){
			posicionar();
			trace("Gah");
		}
	}
}