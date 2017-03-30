package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.Golpejugador;

/**
 * ...
 * @author ...
 */
class Enemigo1 extends BaseEnemigo 
{
	private var etapa:Int = 1;
	private var movimiento:Int = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 30, FlxColor.BROWN);
		acceleration.y = 1500;
	}
	override public function move(){
		super.move();
		if(etapa == 1){
			x -= 1;
			movimiento++;
		}
		if(etapa == 2){
			x+=2;
			movimiento++;
			etapa = 1;
		}
		if (movimiento == 10 && etapa == 1){
			etapa++;
			movimiento = 0;
		}
		
	}
}