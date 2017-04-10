package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BaseEnemigo extends FlxSprite 
{
	private var vidaEnemiga:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		move();
	}
	public function move(){};
	
}