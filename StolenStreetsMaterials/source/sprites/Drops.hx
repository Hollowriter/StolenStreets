package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
/**
 * ...
 * @author MorenaMontero
 */
class Drops extends FlxSprite{
	private var puntos:Int; // cantidad de puntos que da el objeto
	private var valor:Int = FlxG.random.int(0, 3); // decide que tipo de moneda aparecera
	private var creado:Bool = true;
	// te da los puntos
	public function Juntado():Void{
		Reg.guita += puntos;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		// lista de tipos de monedas
		switch (valor){ // el random decide cual de estas aparecera
			case 0: // moneda de color naranja de valor bajo
				makeGraphic(10, 10, FlxColor.ORANGE);
				puntos = 5;
			case 1: // moneda de color rojo de valor mediano
				makeGraphic(10, 10, FlxColor.RED);
				puntos = 10;
			case 2: // moneda de color azul de alto valor
				makeGraphic(10, 10, FlxColor.BLUE);
				puntos = 25;
			case 3: // moneda de color verde con un valor excepcional
				makeGraphic(10, 10, FlxColor.GREEN);
				puntos = 50;
			default: // moneda de emergencia de color blanco con un valor infimo (Para evitar errores al parecer)
				makeGraphic(15, 15, FlxColor.WHITE);
				puntos = 1;	
		}
	}
	public function SetCreado(_creado:Bool){
		creado = _creado;
	}
	
}