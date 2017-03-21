package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class PlataformaFlotante extends FlxSprite 
{
	var puedeMoverse:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(50, 25, FlxColor.BLUE);
		x = 100;
		y = 150;
	}
	public function moverse()
	{
		puedeMoverse = true;
	}
	public function frenar()
	{
		puedeMoverse = false;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}