package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import source.Reg;
/**
 * ...
 * @author BenjaminLlauro(Inicial)
 */
class PlataformaFlotante extends FlxSprite 
{
	var movimientoVertical:Bool = true; //Con tan solo cambiar estos bools, se puede decidir si la plataforma se mueve verticalmente o no.
	var movimientoHorizontal = true;	//Con tan solo cambiar estos bools, se puede decidir si la plataforma se mueve horizontalmente o no.
	var arriba:Bool = false;
	var izquierda:Bool = false;
	var puntoMedioVertical:Float = 0;
	var puntoMedioHorizontal:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(70, 15, FlxColor.BLUE);
		puntoMedioVertical = y;
		puntoMedioHorizontal = x;
		immovable = true;
	}
	public function moverseVertical()
	{
		movimientoVertical = true;
	}
	public function frenarVertical()
	{
		movimientoVertical = false;
	}
	public function moverseHorizontal()
	{
		movimientoHorizontal = true;
	}
	public function frenarHorizontal()
	{
		movimientoHorizontal = false;
	}
	private function chequearVuelo()
	{
		//MOVIMIENTO VERTICAL
		if (movimientoVertical == true)
		{
			//Cambio de direccion vertical
			if (arriba == true && y <= puntoMedioVertical - 50 && movimientoVertical == true)
				arriba = false;
			if (arriba == false && y >= puntoMedioVertical + 50 && movimientoVertical == true)
				arriba = true;
			//Movimiento vertical
			if (arriba == true && movimientoVertical == true)
				velocity.y = Reg.velocidadPlataformasFlotantes * (-1); // cambie esa cosa ++ por velocity
			else if (arriba == false && movimientoVertical == true)
				velocity.y = Reg.velocidadPlataformasFlotantes; // cambie esa cosa ++ por velocity
		}
		//MOVIMIENTO HORIZONTAL
		if (movimientoHorizontal == true)
		{
			//Cambio de direccion horizontal
			if (izquierda == true && x <= puntoMedioHorizontal - 50 && movimientoHorizontal == true)
				izquierda = false;
			if (izquierda == false && x >= puntoMedioHorizontal + 50 && movimientoHorizontal == true)
				izquierda = true;
			//Movimiento horizontal
			if (izquierda == true && movimientoHorizontal == true)
				velocity.x = Reg.velocidadPlataformasFlotantes * (-1); // cambie esa cosa ++ por velocity
			else if (izquierda == false && movimientoHorizontal == true)
				velocity.x = Reg.velocidadPlataformasFlotantes; // cambie esa cosa ++ por velocity
		}
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		chequearVuelo();
	}
}