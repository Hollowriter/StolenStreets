package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
// Plataforma de prueba
class PlataformaPrincipal extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		immovable = true;
		makeGraphic(FlxG.width, 32);
	}
}