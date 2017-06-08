import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
// esto se supone que era un golpe pero ahora esta sin usar
class Ataque extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 16, FlxColor.BROWN);
	}
	// hace desaparecer el golpe
	public function posicionarse(){
		x = -1000;
		y = -1000;
	}
	// chequea si choco contra el jugador
	public function zasEnTodaLaBoca(Ouch:Jugador):Void{
		if (overlaps(Ouch)){
			posicionar();
		}
	}
}