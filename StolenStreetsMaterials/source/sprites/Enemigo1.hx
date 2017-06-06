package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;

/**
 * ...
 * @author MicaelaPereyra(Inicial)
 */
class Enemigo1 extends BaseEnemigo 
{
	private var still:Bool;
	private var direc:Bool;
	private var golpe:GolpeEnemigo;
	private var timer:Int;
	private var golpeFuerte:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 30, FlxColor.BROWN);
		vidaEnemiga = 10;
		still = false;
		golpe = new GolpeEnemigo(1000, 1000);
		timer = 0;
		golpeFuerte = 0;
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
			timer = 0;
			if (x < enemyRightMin && x < (enemyRightMax))
			{
				x += 2;
				direc = false;
				golpe.PosicionarGE();
			}
			if (x > enemyLeftMin && x > (enemyLeftMax))
			{
				x -= 2;
				direc = true;
				golpe.PosicionarGE();
			}
		}
		
		if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - Reg.widthJugador * 2))
			|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + Reg.widthJugador * 2)))
		{
			if (timer <= Reg.effectTimer){
				golpeFuerte++;
				still = true;
				if (golpeFuerte > Reg.golpeFuerteMax)
				{
					trace("en golpe fuerte");
					golpe.SetGolpeFuerte(true);
					golpe.PunietazoEnemigo(this, direc);
					//golpe.SetGolpeFuerte(false); comentado por problemas de hitbox, pero funca (averiguar en que momento retomar golpes normales de enemigo)
					golpeFuerte = 0;
				}
				else golpe.PunietazoEnemigo(this, direc);
			}
			else{
				if (timer > Reg.maxEffectTimer){
					timer = 0;
				}
				golpe.PosicionarGE();
			}
			timer++;
			//golpeFuerte++;
			// trace("work");
		}
		else
			still = false;
		
		/*trace(golpe.getPosition());
		trace(this.x);
		trace(this.y);*/
	}
	
	public function GetGolpeEnemigo():GolpeEnemigo
	{
		return golpe;
	}
}