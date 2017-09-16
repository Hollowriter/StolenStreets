package sprites;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author ...
 */
class Puertas extends FlxSprite 
{
	static var enemigosAAsesinar:Int = 1;
	var enemigosPedidos:Int = 0;
	var empujarJugador:Bool;
	var puertaAbierta:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(15, 70, FlxColor.fromRGB(144, 255, 155));
		immovable = true;
	}
	public function SetEnemigosAAsesinar(cant:Int){
		enemigosAAsesinar = cant;
		enemigosPedidos = enemigosAAsesinar;
	}
	public function GetEnemigosPedidos(){
		return enemigosPedidos;
	}
	public function CheckeodePuertas(){
		if (enemigosAAsesinar <= Reg.enemigosMuertos){
			kill();
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
	}
}