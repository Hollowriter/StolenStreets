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
 * @author MorenaMontero
 */
class Obstaculo extends FlxSprite{ // Base para una clase por lo que no comentare mas hasta que tenga su funcionamiento
	private var destructible:Int = FlxG.random.int(0,1);
	private var danio:Int = 0;
	public function Golpeada(){
		if (destructible == 1){
			danio += 1;
			if (danio == 3){
				kill();
				Reg.puntaje += 10;
			}
		}
		else {
			x += 10;
		}
	}
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		acceleration.y = 100;
		if (destructible == 1)
			makeGraphic(30, 30, FlxColor.RED);
		else if (destructible == 0)
			makeGraphic (30, 30, FlxColor.ORANGE);

	}
	
}