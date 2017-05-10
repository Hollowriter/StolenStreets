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
 * @author MicaelaPereyra
 */
class Enemigo1 extends BaseEnemigo 
{
	/*private var etapa:Int = 1;
	private var movimiento:Int = 0;*/
	private var still:Bool;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 30, FlxColor.BROWN);
		vidaEnemiga = 10;
		still = false;
	}
	// movimiento de este enemigo
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
		
		if (!still)
		{
			if (x < Reg.posXjugador && x < (Reg.posXjugador - Reg.widthJugador * 2))
			{
				x += 2;
			}
			if (x > Reg.posXjugador && x > (Reg.posXjugador + Reg.widthJugador * 2))
			{
				x -=2;
			}
		}
		
		if (x < Reg.posXjugador - Reg.widthJugador && x > (Reg.posXjugador - Reg.widthJugador * 2))
		{
			still = true;
			trace("work");
		}
		else
			still = false;
		
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