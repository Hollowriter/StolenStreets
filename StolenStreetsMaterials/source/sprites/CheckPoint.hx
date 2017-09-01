package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author MorenaMontero
 */
class CheckPoint extends FlxSprite 
{
	private var activo:Bool = false;
	private var pasado:Bool = false;

	public function GetX(){
		return x;
	}
	public function GetY(){
		return y;
	}
	public function GetPasado(){
		return pasado;
	}
	public function SetPasado(_Pasado:Bool){
		pasado = _Pasado;
	}
	public function GetActivo(){ 
		return activo;
	}
	public function SetActivo(pjPaso:Bool){
		activo = pjPaso;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16, FlxColor.fromRGB(160, 60, 160));
	}
	
}