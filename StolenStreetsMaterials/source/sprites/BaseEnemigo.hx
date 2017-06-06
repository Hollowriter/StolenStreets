package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sprites.GolpeEnemigo;
import source.Reg;

/**
 * ...
 * @author MicaelaPereyra
 */
class BaseEnemigo extends FlxSprite 
{
	private var vidaEnemiga:Int; // vida del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:UInt; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var punioEnemigo:GolpeEnemigo; // nuevo golpe del enemigo
	
	private var enemyRightMin:Float;
	public var enemyRightMax:Float;
	public var enemyLeftMin:Float;
	public var enemyLeftMax:Float;
	

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		punioEnemigo = new GolpeEnemigo(1000, 1000);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		
		enemyRightMin = Reg.posXjugador;
		enemyRightMax = Reg.posXjugador - (Reg.widthJugador * 2);
		enemyLeftMin = Reg.posXjugador;
		enemyLeftMax = Reg.posXjugador + (Reg.widthJugador * 2);
		
		move();
	}
	public function move(){};
	public function gotHitted(){};
	
}