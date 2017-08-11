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
	private var Agarrada:Bool; // para determinar si el jugador intenta hacer un agarre
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 11, FlxColor.RED);
		GolpeDuro = false;
		Agarrada = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
	// hace "desaparecer" el puñetazo
	public function posicionar():Void{
		x = Reg.posicionDeLosPunios;
		y = Reg.posicionDeLosPunios;
		if (GolpeDuro == true){ // esto es para evitar que el golpe duro quede asi eternamente
			GolpeDuro = false;
		}
		if (Agarrada == true){ // esto es para que la agarrada no quede como agarrada por siempre y para evitar errores con los enemigos
			Agarrada = false;
		}
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
			else if (corriendo == true){
				GolpeDuro = true;
			}
			else{
				GolpeDuro = false; //esto hay que cambiarlo
			}
		}
	}
	// colision del golpe
	public function ColisionconCaja(caja:Obstaculo, personaje:Jugador):Void{
		if (overlaps(caja) && caja.GetGolpeado() == false && Agarrada == false){
			posicionar();
			caja.Golpeada(personaje);
			caja.SetGolpeado(true);
		}
	}
	public function ColisionDelGolpe(Pum:BaseEnemigo, personaje:Jugador):Void{ // ahora tambien tiene al jugador por el tema de chequear el agarre
		if (overlaps(Pum) && !(Pum.Morir())){ // si el golpe es del jugador y choca con el enemigo
			if (Agarrada == false){
				posicionar(); // lo hace desaparecer
				if (Pum.GetHurt() == source.EstadoEnemigo.Normal){ // chequea que el enemigo no haya recibido un golpe con anterioridad
					if (GolpeDuro == false){ // si es un golpe normal
						Pum.SetHurt(source.EstadoEnemigo.Lastimado); // lo lastima
						Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorNormal); // le quita vida con el setter y getter
						Pum.animation.play("Ouch");
						personaje.SetCheck(false);
					}
					else if (GolpeDuro == true || Pum.GetHurt() == source.EstadoEnemigo.Agarrado){ // pero si es un golpe duro
						Pum.SetHurt(source.EstadoEnemigo.Lanzado); // lo lastima duramente
						Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorNormal);
						personaje.SetCheck(false);
					}
					Pum.SetTimer(0); // y reinicia el timer de comportamiento del mismo
				}
			}
			else if (Agarrada == true){
				if (overlaps(Pum) && !(Pum.Morir())){
					personaje.velocity.x = 0;
					personaje.velocity.y = 0;
					Pum.SetHurt(source.EstadoEnemigo.Agarrado);
					personaje.animation.play("Agarrando");
				}
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
	// getter y setter del agarre
	public function GetAgarrada(){
		return Agarrada;
	}
	public function SetAgarrada(agarre:Bool){
		Agarrada = agarre;
	}
}