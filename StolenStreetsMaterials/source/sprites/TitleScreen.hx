package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
class TitleScreen extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.logo3__png, false, 190, 190);
	}
}