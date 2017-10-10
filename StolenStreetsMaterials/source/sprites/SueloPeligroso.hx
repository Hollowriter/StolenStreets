package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import source.Reg;

/**
 * ...
 * @author MorenaMontero(Inicial)
 */
class SueloPeligroso extends FlxSprite{
	private var pisado:FlxSound;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X - 1, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PinchesPlaceholder__png);
		immovable = true;
		pisado = new FlxSound();
		pisado.loadEmbedded(AssetPaths.pinches__wav, false);
	}
	public function SonidoPisada(){
		pisado.play();
	}
}