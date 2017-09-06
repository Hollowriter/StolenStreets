package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.FlxG;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Musica extends FlxSprite{
	//private var musicaNivel1:FlxSound;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
	}
	public function PlayMusic():Void{
		if (FlxG.sound.music == null){
			FlxG.sound.playMusic(AssetPaths.musicaoficial__ogg, 1, true);
		}
	}
	
}