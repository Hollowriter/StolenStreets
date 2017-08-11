package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class GuiaEnemigo extends FlxSprite{
	private var colision:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(20, 20, FlxColor.PURPLE);
		colision = false;
	}
	public function Seguidor(enemigoX:Float, enemigoY:Float, enemigoFlip:Bool):Void{
		x = enemigoX - 10;
		y = enemigoY + 70;
		flipX = enemigoFlip;
		if (flipX == true){
			x = enemigoX + 30;
		}
	}
	public function HayPiso(tMap:FlxTilemap):Void{
		if (overlaps(tMap)){
			colision = true;
		}
		else{
			colision = false;
		}
	}
	public function GetColision():Bool{
		return colision;
	}
}