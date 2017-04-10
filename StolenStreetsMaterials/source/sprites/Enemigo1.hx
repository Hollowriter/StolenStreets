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
		vidaEnemiga = 10;
	}
	
	override public function move(){
		super.move();
		/*if(etapa == 1){
			//x -= 1;
			velocity.x = 0;
			velocity.x =100;
			movimiento++;
		}
		if(etapa == 2){
			//x+=2;
			velocity.x = 0;
			velocity.x = -100;
			movimiento++;
			etapa = 1;
		}
		if (movimiento == 10 && etapa == 1){
			etapa++;
			movimiento = 0;
		}*/
		if (x < Reg.posXjugador && x < (Reg.posXjugador - Reg.widthJugador * 2))
		{
			x++;
		}
		if (x > Reg.posXjugador && x > (Reg.posXjugador + Reg.widthJugador * 2))
		{
			x--;
		}
	}
	
	/*override public function getEnemigoVida()
	{
		return vidaEnemiga;
	}
	
	override public function checkKilled()
	{
		return killed;
	}*/
}