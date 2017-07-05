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
	private var combo:Bool;
	//private var direc:Bool;
	// private var golpe:GolpeEnemigo;
	//private var timer:Int;
	private var golpesVarios:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.ThyEnemigo__png, true, 50, 70);
		animation.add("Normal", [0, 0], 2, true);
		animation.add("Caminar", [5, 6, 7, 8, 9], 4, true);
		animation.add("Caer", [15], 2, true);
		animation.add("Pegar", [1, 2, 3], 7, false);
		animation.add("Ouch", [14, 14, 14], 5, false);
		animation.play("Normal");
		vidaEnemiga = 80;
		still = false;
		combo = false;
		punioEnemigo = new GolpeEnemigo(1000, 1000);
		timer = 0;
		comboTimer = 0;
		golpesVarios = 0;
		isHurt = 0;
		saltito = false;
	}
	// movimiento de este enemigo
	override public function move(){
		super.move();
		if (isHurt == 0 || saltito == false){ // mientras no esta lastimado y no esta en el aire va poder moverse
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
				direccion = false;
				punioEnemigo.PosicionarGE();
				animation.play("Caminar");
				flipX = true;
			}
			if (x > enemyLeftMin && x > (enemyLeftMax))
			{
				x -= 2;
				direccion = true;
				punioEnemigo.PosicionarGE();
				animation.play("Caminar");
				flipX = false;
			}
		}
		if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - Reg.widthJugador * 2))
			|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + Reg.widthJugador * 2)))
		{
			if (timer <= Reg.effectTimer){
				golpesVarios++;
				animation.play("Pegar");
				still = true;
				if (golpesVarios > Reg.golpeFuerteMax)
				{
					//trace("en golpe fuerte");
					punioEnemigo.SetGolpeFuerte(true);
					punioEnemigo.PunietazoEnemigo(this, direccion);
					//golpe.SetgolpesVarios(false); comentado por problemas de hitbox, pero funca (averiguar en que momento retomar golpes normales de enemigo)
					//golpesVarios = 0;
				}
				else punioEnemigo.PunietazoEnemigo(this, direccion);
				
				if (golpesVarios > Reg.golpeCombo)//aplicar el timer para duracion entre golpe y golpe de combo.
				{
					combo = true;
					//trace("c-c-c-combo breaker!");
					punioEnemigo.PunietazoEnemigo(this, direccion);
					if (comboTimer > Reg.comboTimer)
					{
						//trace("c-c-c-combo breaker!");
						if (comboTimer > Reg.comboTimerMax)
						{
							punioEnemigo.PosicionarGE();
							punioEnemigo.PunietazoEnemigo(this, direccion);
							golpesVarios = 0;
							combo = false;
							comboTimer = 0;
						}
					}
					comboTimer++;
					
				}
				else punioEnemigo.PunietazoEnemigo(this, direccion);
			}
			else{
				if (timer > Reg.maxEffectTimer){
					timer = 0;
				}
				if (!combo)
				{
					punioEnemigo.PosicionarGE();
				}
				punioEnemigo.SetGolpeFuerte(false);
			}
			timer++;
			//comboTimer++;
			//golpesVarios++;
			// trace("work");
		}
		else
			still = false;
		}
		else if (isHurt == 1){
			animation.play("Ouch");
		}
		else if (isHurt == 2 && saltito == true){
			animation.play("Caer");
		}
		/*trace(golpe.getPosition());
		trace(this.x);
		trace(this.y);*/
	}
	/*override public function EnElAire(){
		super.EnElAire();
	}
	public override function update(elapsed:Float):Void{
		super.update(elapsed);
		EnElAire();
		move();
	}*/
	/*public function GetGolpeEnemigo():GolpeEnemigo
	{
		return golpe;
	}*/
}