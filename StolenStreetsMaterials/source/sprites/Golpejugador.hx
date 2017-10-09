package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;
import sprites.Jugador;
import flixel.system.FlxSound;

/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
class Golpejugador extends FlxSprite{
	private var sonidoGolpeJugador:FlxSound;
	private var sonidoGolpeJugadorFuerte:FlxSound;
	private var GolpeDuro:Bool; // detecta cuando es un golpe que te tira al piso
	private var Agarrada:Bool; // para determinar si el jugador intenta hacer un agarre
	private var diferenciaPatadaMiliY = -15;
	private var diferenciaPatadaX = 5;
		
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 9, FlxColor.RED);
		sonidoGolpeJugador = new FlxSound();
		sonidoGolpeJugador.loadEmbedded(AssetPaths.slap__wav);
		sonidoGolpeJugador.volume = 100;
		sonidoGolpeJugadorFuerte = new FlxSound();
		sonidoGolpeJugadorFuerte.loadEmbedded(AssetPaths.strongpunch__wav);
		sonidoGolpeJugadorFuerte.volume = 100;
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
	public function PunietazoJugador(?personaje:Jugador = null, mirando:Bool, saltando:Bool, corriendo:Bool, usaASofi:Bool):Void{ // Pendiente de testear
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
				if (usaASofi == true){
					y = personaje.y + Reg.patadaJugadorVertical - height; // por lo que se encuentra mas abajo
					if (mirando == false)
						x += diferenciaPatadaX;
					else
						x -= diferenciaPatadaX;
				}
				else{
					y = personaje.y + (Reg.patadaJugadorVertical + diferenciaPatadaMiliY);
					if (mirando == false)
						x += 5;
					else
						x -= 5;
				}
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
	public function ColisionDelGolpe(Pum:BaseEnemigo, personaje:Jugador):Void{ // ahora tambien tiene al jugador por el tema de chequear el agarre
		if (overlaps(Pum) && !(Pum.GetMuerto())){ // si el golpe es del jugador y choca con el enemigo
			if (Pum.GetHurt() == source.EstadoEnemigo.Normal && Agarrada == false){ // chequea que el enemigo no haya recibido un golpe con anterioridad
				if (GolpeDuro == false){ // si es un golpe normal
					Pum.SetHurt(source.EstadoEnemigo.Lastimado); // lo lastima
					Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorNormal); // le quita vida con el setter y getter
					personaje.SetCheck(false);
					sonidoGolpeJugador.play();
				}
				if (GolpeDuro == true || GolpeDuro == false && Pum.GetHurt() == source.EstadoEnemigo.Saltando 
				|| GolpeDuro == true && Pum.GetHurt() == source.EstadoEnemigo.Saltando){ // pero si es un golpe duro
					Pum.SetHurt(source.EstadoEnemigo.Lanzado); // lo lastima duramente
					if (personaje.GetJump() == true || personaje.GetCorriendo() == true){
						Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorFuerte);
					}
					else{
						Pum.SetVida(Pum.GetVida() + Reg.danioPunioJugadorTercero);
					}
					personaje.SetCheck(false);
					GolpeDuro = false;
					sonidoGolpeJugadorFuerte.play();
				}
				Pum.SetTimer(0); // y reinicia el timer de comportamiento del mismo
				posicionar(); // lo hace desaparecer
			}
			if (Agarrada == true){
				if (overlaps(Pum) && !(Pum.GetMuerto())){
					personaje.velocity.x = 0;
					personaje.velocity.y = 0;
					Pum.SetHurt(source.EstadoEnemigo.Agarrado);
					personaje.animation.play("Agarrando");
					GolpeDuro = true;
				}
			}
		}
		if (!overlaps(Pum) && Pum.GetHurt() == source.EstadoEnemigo.Agarrado){
			if (Pum.GetHurt() != source.EstadoEnemigo.Lanzado && Pum.GetHurt() != source.EstadoEnemigo.Lastimado){
				Pum.SetHurt(source.EstadoEnemigo.Normal);
				Pum.GetGolpeEnemigo().PosicionarGE();
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