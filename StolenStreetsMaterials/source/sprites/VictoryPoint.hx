package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import source.Reg;
/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class VictoryPoint extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(20, 20, FlxColor.WHITE);
	}
	public function NextLevel(jugador:Jugador){
		if (overlaps(jugador)){
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
	}
}