package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Golpe extends FlxSprite{
	// private var Time:Int; (sin usar)
	private var YouundMe:Bool; // chequea si es un golpe del jugador (true) o del enemigo (false)
	private var hardHit:Bool; // detecta cuando es un golpe que te tira al piso
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(11, 11, FlxColor.RED);
		// Reg.golpesGroup.add.(this);
		// Time = 0;
		YouundMe = false;
		hardHit = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
	// hace "desaparecer" el puñetazo
	public function posicionar():Void{
		x = 1000;
		y = 1000;
	}
	// puñetazo del jugador
	public function niapi(?personaje:Jugador = null, mirando:Bool, saltando:Bool):Void{ // Pendiente de testear
		if (personaje != null){ // si el personaje existe
			YouundMe = true; // chequea que el golpe es del jugador
			y = personaje.y; // se encuentra a la misma altura del personaje
			if (mirando == false){
				x = personaje.x + 25; // pero mas adelante de el
			}
			else if (mirando == true){
				x = personaje.x - 5; // pero mas adelante de el
			}
			if (saltando == true){ // esto es un salto y patada
				y = personaje.y + 10; // por lo que se encuentra mas abajo
			}
			if (personaje.getCombo() > 2 || saltando == true){ // golpe duro comprobado
				hardHit = true;
			}
			else{
				hardHit = false;
			}
		}
	}
	// puñetazo del enemigo
	public function niapiDos(?atacante:Enemigo = null, observando:Bool):Void{
		if (atacante != null){ // si el enemigo existe
			YouundMe = false; // chequea que el golpe no es del jugador
			y = atacante.y; // esta a la misma altura del enemigo
			if (observando == false){
				x = atacante.x + 25; // pero mas adelante de el
			}
			else if (observando == true){
				x = atacante.x - 5; // pero mas adelante de el
			}
		}
	}
	// colision del golpe
	public function zasEnTodaLaBoca(Ouch:Jugador, Pum:Enemigo):Void{
		if (overlaps(Pum) && YouundMe == true){ // si el golpe es del jugador y choca con el enemigo
			posicionar(); // lo hace desaparecer
			if (Pum.getHurt() == false){ // chequea que el enemigo no haya recibido un golpe con anterioridad
				Pum.setHurt(true); // y lo lastima
				Pum.setTimer(0); // reseteando el timer de comportamiento del mismo
			}
		}
		else if (overlaps(Ouch) && YouundMe == false){ // si el golpe es del enemigo y choca con el jugador
			posicionar(); // lo hace desaparecer
			if (Ouch.getMeHurt() == false){ // chequea que el personaje no haya recibido un golpe con anterioridad
				Ouch.setCombo(0); // rompe el combo
				Ouch.setTime(0); // reinicia el timer
				Ouch.setMeHurt(true); // lo lastima
				Ouch.velocity.x = 0; // y lo detiene un rato
			}
		}
	}
	// getter del gancho o golpe duro
	public function getHardHit(){
		return hardHit;
	}
}