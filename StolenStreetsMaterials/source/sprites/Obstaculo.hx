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
	// private var direccionDelGolpe:Bool = false; // indica la direccion del golpe para determinar velocidad positiva o negativa (ignorenlo)
	private var contador:Int = 0; // ahora lo uso para saber cuanto tiempo se mueve la caja indestructible
	public function Golpeada(personaje:Jugador){
		golpeado = false;
		if (destructible == 1 && golpeado == false){
			danio += 1; //por cada golpe lastima la caja 6 veces. 3 golpes para matarla.
			contador = Reg.effectTimer - 5;
			trace ("crash");
			if (danio == 3){
					dropeable = new DropFalling(x+14, y+29); 
					dropeable.SetBroken(true);
				kill();
				Reg.puntaje += 10;
			}
		}
		if (personaje.x < x){
			velocity.x += 150; // cambia su velocidad
			contador = Reg.effectTimer * 2; // empieza el contador de duracion de movimiento
			// direccionDelGolpe = false; // la direccion en la que le pegaste (ignorenlo)
		}
		else if (personaje.x > x){
		    velocity.x -= 150; // cambia su velocidad
			contador = Reg.effectTimer * 2; // empieza el contador de duracion de movimiento
			// direccionDelGolpe = true; // la direccion en la que pegaste (ignorenlo)
		}
	}
	public function GetDrop(){ // esto retorna el objeto si tiene alguno
		return dropeable;
	}
	public function Movement(){ // esta funcion es para el movimiento
			if (contador > 0){ // y el contador fue activado
				if (velocity.x > 0){ // se fija en que direccion fue segun la velocidad
					if (velocity.x != 0){ // se para en 0 asi no va en la direccion contraria
						velocity.x -= 2; // y de ahi va bajando paulatinamente la velocidad del objeto
						// trace(velocity.x);
					}
				}
				else if (velocity.x < 0){ // se fija en que direccion fue segun la velocidad
					if (velocity.x != 0){ // se fija que la velocidad no sea 0 asi no se va la caja para el lado contrario
						velocity.x += 2; // y desciende de a poco su velocidad
						// trace(velocity.x);
					}
				}
				contador--; // y el contador disminuye
			}
			else{
				velocity.x = 0; // cuando llega a 0, la caja queda totalmente quieta
			}
	}
	public function SetGolpeado(punched:Bool){
		golpeado = punched;
	}
	public function GetGolpeado(){
		return golpeado;
	}
	public function Inmunidad(){
		if (golpeado == true){
			contador--;
			if (contador <= 0){
				golpeado = false;
			}
		}
	}
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500;
		if (destructible == 1){
			makeGraphic(30, 30, FlxColor.RED);
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
	override public function update(elapsed:Float){ // este es el update
		super.update(elapsed);
		Movement(); // con la funcion de movimiento
		Inmunidad();
	}
}