package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import source.Reg;

/**
 * ...
 * @author ...
 */
class SueloPeligroso extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X - 1, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PinchesPlaceholder__png);
		immovable = true;
	}
}