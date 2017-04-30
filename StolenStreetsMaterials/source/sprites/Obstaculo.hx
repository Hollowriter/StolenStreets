package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.DropFalling;
import source.Reg;
/**
 * ...
 * @author MorenaMontero(Inicial)
 */
class Obstaculo extends FlxSprite{ // Base para una clase por lo que no comentare mas hasta que tenga su funcionamiento
	private var destructible:Int = FlxG.random.int(0, 1);
	private var dropeable:DropFalling; // esto es para asignarle un drop
	private var danio:Int = 0;
	private var golpeado:Bool = false;
	private var contador:Int = 0;
	public function Golpeada(personaje:Jugador){
		if (destructible == 1 && golpeado == false){
			danio += 1;
			//golpeado = true;
			if (danio == 3){
				if (dropeable != null){ // si existe un drop, aparece cuando la caja se destruye
					dropeable.x = x; // en la misma posicion
					dropeable.y = y; // que la caja
					dropeable.SetBroken(true); // y activa su gravedad
				}
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
	public function GetDrop(){ // esto retorna el objeto si tiene alguno
		return dropeable;
	}
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		if (destructible == 1){
			makeGraphic(30, 30, FlxColor.RED);
			dropeable = new DropFalling(1000, 1000); // crea el objeto drop en una posicion remota solo si el objeto es destruible
		}
		else if (destructible == 0){
			makeGraphic (30, 30, FlxColor.ORANGE);
		}
		/*if (golpeado == true){
			for (i in 0...10)
				contador += 1;
			golpeado = false;
			contador = 0;
			 ver mas tarde*/ 
	}
}