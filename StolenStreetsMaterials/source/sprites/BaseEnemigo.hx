package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BaseEnemigo extends FlxSprite 
{
	//private var killed:Bool;
	//private var timer:Int; // timer de comportamiento (una AI de mierda)
	private var vidaEnemiga:Int; // vida del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var puniosEnemigo:GolpeEnemigo; // nuevo golpe del enemigo

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		//killed = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		move();
	}
	public function move(){};
	//public function getEnemigoVida(){};
	//public function checkKill(){};
	public function gotHitted(){};
	public function GetGolpeEnemigo(){};
	
}