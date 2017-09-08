package sprites;

//import cpp.Void;
import cpp.Void;
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
	private var movete:Bool;
	private var noEnemigos:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(20, 20, FlxColor.PURPLE);
		movete = false;
		noEnemigos = false;
	}
	public function Seguidor(enemigoX:Float, enemigoY:Float, enemigoFlip:Bool){
		x = enemigoX - 10;
		y = enemigoY + 70;
		flipX = enemigoFlip;
		if (flipX == true){
			x = enemigoX + 30;
		}
	}
	public function DetectorDeCamaradas(enemigoX:Float, enemigoY:Float, enemigoFlip:Bool){
		flipX = enemigoFlip;
		y = enemigoY + 20;
		if (flipX == false){
			x = enemigoX - 10;
		}
		else if (flipX == true){
			x = enemigoX + 50;
		}
	}
	public function HayPiso(tMap:FlxTilemap){
		if (overlaps(tMap)){
			movete = true;
		}
		else{
			movete = false;
		}
	}
	public function HayUnCamarada(meinFriend:BaseEnemigo){
		if (overlaps(meinFriend)){
			noEnemigos = false;
		}
		else{
			noEnemigos = true;
		}
	}
	public function GetMovete():Bool{
		return movete;
	}
	public function SetNoEnemigos(detector:Bool){
		noEnemigos = detector;
	}
	public function GetNoEnemigos():Bool{
		return noEnemigos;
	}
}