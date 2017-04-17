package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sprites.GolpeEnemigo;

/**
 * ...
 * @author MicaelaPereyra
 */
class BaseEnemigo extends FlxSprite 
{
	//private var killed:Bool; (Sin utilizar)
	//private var timer:Int; // timer de comportamiento (una AI de mierda) (Sin utilizar)
	private var vidaEnemiga:Int; // vida del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var punioEnemigo:GolpeEnemigo; // nuevo golpe del enemigo

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		punioEnemigo = new GolpeEnemigo(1000, 1000);
		//killed = false; (Sin utilizar)
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		move();
	}
	public function move(){};
	//public function getEnemigoVida(){}; (Sin utilizar)
	//public function checkKill(){}; (Sin utilizar)
	public function gotHitted(){};
	public function GetGolpeEnemigo(){};
	
}