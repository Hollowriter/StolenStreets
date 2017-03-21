package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class PlataformaFlotante extends FlxSprite 
{
	var puedeMoverse:Bool = true; // MUY IMPORTANTE. cCon esto se decide si la plataforma es movil o no.
	var arriba:Bool = false;
	var puntoMedio:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(50, 25, FlxColor.BLUE);
		x = 100;
		y = 150;
		puntoMedio = y;
	}
	public function moverse()
	{
		puedeMoverse = true;
	}
	public function frenar()
	{
		puedeMoverse = false;
	}
	private function chequearVuelo()
	{
		//CAMBIOS DE DIRECCION (ARRIBA Y ABAJO):
		if (arriba == true && y <= puntoMedio - 50 && puedeMoverse == true)
			arriba = false;
		if (arriba == false && y >= puntoMedio + 50 && puedeMoverse == true)
			arriba = true;
		//MOVIMIENTO VERTICAL:
		if (arriba == true && puedeMoverse == true)
			y--;
		else if (arriba == false && puedeMoverse == true)
			y++;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		chequearVuelo();
	}
}