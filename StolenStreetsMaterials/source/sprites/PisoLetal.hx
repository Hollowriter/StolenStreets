package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;

/**
 * ...
 * @author Benjamín Llauró...
 */
class PisoLetal extends FlxSprite {
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		//256 X 16
		loadGraphic(AssetPaths.PlataformaLetal__png, true, 91, 23);
		immovable = true;
		animation.add("LaLetal", [0, 1, 2], 8, true);
		animation.play("LaLetal");
		
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
}