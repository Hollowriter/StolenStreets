package sprites;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import source.Reg;

/**
 * ...
 * @author ...
 */
class Puertas extends FlxSprite 
{
	static var enemigosAAsesinar:Int = 21;
	var enemigosPedidos:Int = 0;
	var empujarJugador:Bool;
	var puertaAbierta:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(15, 70, FlxColor.fromRGB(144, 255, 155));	
	}
	public function SetEnemigosAAsesinar(cant:Int){
		enemigosAAsesinar = cant;
		enemigosPedidos = enemigosAAsesinar;
	}
	public function GetEnemigosPedidos(){
		return enemigosPedidos;
	}
	public function Enemigoasesinado(){
		enemigosAAsesinar--;
	}
	public function CheckeodeEmpuje(){
		if (Reg.posXjugador > x){
			empujarJugador = true; //-- la empuja para la izquierda
		}
		else 
			empujarJugador = false;//++ la empuja para la derecha
	}
	public function CheckeodePuertas(){
		if (enemigosAAsesinar == enemigosPedidos)
			puertaAbierta = true;
		else
			puertaAbierta = false;
		return puertaAbierta;
	}
}