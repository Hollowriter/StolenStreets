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
class Obstaculo extends FlxSprite{ // Base para una clase por lo que no comentare mas hasta que tenga su funcionamiento
	private var destructible:Int = FlxG.random.int(0,1);
	private var danio:Int = 0;
	private var golpeado:Bool = false;
	private var contador:Int = 0;
	public function Golpeada(personaje:Jugador){
		if (destructible == 1 && golpeado == false){
			danio += 1;
			//golpeado = true;
			if (danio == 3){
				kill();
				Reg.puntaje += 10;
			}
		}
		else if (destructible == 0 && personaje.x < x){
			x += 30;
		}
		else if (destructible == 0 && personaje.x > x)
		    x -= 30;
	}
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		acceleration.y = 100;
		if (destructible == 1)
			makeGraphic(30, 30, FlxColor.RED);
		else if (destructible == 0)
			makeGraphic (30, 30, FlxColor.ORANGE);
	
		/*if (golpeado == true){
			for (i in 0...10)
				contador += 1;
			golpeado = false;
			contador = 0;
			 ver mas tarde*/ 
	}
	
}