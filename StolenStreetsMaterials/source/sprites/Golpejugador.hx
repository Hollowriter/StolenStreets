package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;
import sprites.Jugador;

/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
class Golpejugador extends FlxSprite{
	private var GolpeDuro:Bool; // detecta cuando es un golpe que te tira al piso
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 11, FlxColor.RED);
		GolpeDuro = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
	// hace "desaparecer" el puñetazo
	public function posicionar():Void{
		x = Reg.posicionDeLosPunios;
		y = Reg.posicionDeLosPunios;
	}
	// puñetazo del jugador
	public function PunietazoJugador(?personaje:Jugador = null, mirando:Bool, saltando:Bool, corriendo:Bool):Void{ // Pendiente de testear
		// trace("ESTOY EN PUNIETAZOJUGADOR");
		if (personaje != null){ // si el personaje existe
			y = personaje.y; // se encuentra a la misma altura del personaje
			if (mirando == false){
				x = personaje.x + Reg.punietazoJugadorDerecha; // pero mas adelante de el
				y = personaje.y + Reg.punietazoJugadorPosVertical;
			}
			else if (mirando == true){
				x = personaje.x + Reg.punietazoJugadorIzquierda; // pero mas adelante de el
				y = personaje.y + Reg.punietazoJugadorPosVertical;
			}
			if (saltando == true){ // esto es un Salto y patada
				y = personaje.y + Reg.patadaJugadorVertical; // por lo que se encuentra mas abajo
			}
			if (personaje.GetCombo() > 2 || saltando == true){ // golpe duro comprobado
				GolpeDuro = true;
			}
			else if (corriendo == true)
				GolpeDuro = true;
			else
				GolpeDuro = false; //esto hay que cambiarlo
		}
	}
	// colision del golpe
		public function ColisionconCaja(caja:Obstaculo, personaje:Jugador):Void{
			if (overlaps(caja) && caja.GetGolpeado() == false){
				posicionar();
				caja.Golpeada(personaje);
				caja.SetGolpeado(true);
			}
		}
	public function ColisionDelGolpe(Pum:BaseEnemigo):Void{ // ahora tambien tiene al jugador por el tema de chequear el agarre
		if (overlaps(Pum) && !(Pum.Morir())){ // si el golpe es del jugador y choca con el enemigo
			posicionar(); // lo hace desaparecer
			if (Pum.GetHurt() == 0){ // chequea que el enemigo no haya recibido un golpe con anterioridad
				if (GolpeDuro == false){ // si es un golpe normal
					Pum.SetHurt(1); // lo lastima
					Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorNormal); // le quita vida con el setter y getter
					trace(Pum.GetVida());
				}
				else if (GolpeDuro == true){ // pero si es un golpe duro
					Pum.SetHurt(2); // lo lastima duramente
					Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorNormal);
					trace(Pum.GetVida());
				}
				Pum.SetTimer(0); // y reinicia el timer de comportamiento del mismo
			}
		}
	}
	// getter y setter del gancho o golpe duro
	public function GetGolpeDuro(){
		return GolpeDuro;
	}
	public function SetGolpeDuro(dureza:Bool){
		GolpeDuro = dureza;
	}
}