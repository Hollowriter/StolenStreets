package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author ...
 */
class CheckPoint extends FlxSprite 
{
	private var checkeado:Bool = false;

	public function GetCheck(){ 
		return checkeado;
	}
	public function SetCheck(pjPaso:Bool){
		checkeado = pjPaso;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(1, 1, FlxColor.fromRGB(160, 60, 160));
	}
	
}