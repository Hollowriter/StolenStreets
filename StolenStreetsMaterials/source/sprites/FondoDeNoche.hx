package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import source.Reg;

/**
 * ...
 * @author ...
 */
class FondoDeNoche extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Noche__png, false, 1920, 1080);
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		x = Reg.posXjugador - 1000;
		y = Reg.posYjugador - 500;
	}
}