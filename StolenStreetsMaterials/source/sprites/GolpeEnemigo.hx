package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author RodrigoDiazKlipphan(inciial)
 */
class GolpeEnemigo extends FlxSprite{
	private var golpeFuerte:Bool; // check gancho
	private var ljug:Int; // para afectar al jugador
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		makeGraphic(11, 11, FlxColor.BLUE);
		golpeFuerte = false;
		ljug = 0;
	}
	override public function update(elapsed:Float):Void{
		
	}
	// hace desaparecer el golpe
	public function PosicionarGE():Void{
		x = Reg.posicionDeLosPunios;
		y = Reg.posicionDeLosPunios;
	}
	// colision del golpe con le jugador
	public function ColisionDelGolpeEnemigo(Ouch:Jugador):Void{
		if (overlaps(Ouch)){ // si el golpe es del enemigo y choca con el jugador
			PosicionarGE(); // lo hace desaparecer
			if (Ouch.GetMeHurt() == 0){ // chequea que el personaje no haya recibido un golpe con anterioridad
				Ouch.SetCombo(0); // rompe el Combo
				Ouch.SetTime(0); // reinicia el timer
				Ouch.SetMeHurt(1); // lo lastima
				Ouch.velocity.x = 0; // y lo detiene un rato
				ljug = Ouch.GetVida(); // la variable almacena la vida del jugador
				if (!golpeFuerte) ljug -= 25; // la resta
				else ljug -= 50; // la resta
				Ouch.SetVida(ljug); // y la setea
			}
		}
	}
	// colocacion del golpe enemigo
	public function PunietazoEnemigo(?atacante:Enemigo1 = null, observando:Bool):Void{
		if (atacante != null){ // si el enemigo existe
			// YouundMe = false; // chequea que el golpe no es del jugador (No utilizado)
			y = atacante.y; // esta a la misma altura del enemigo
			if (observando == false){
				x = atacante.x + 50; // pero mas adelante de el
			}
			else if (observando == true){
				x = atacante.x - 20; // pero mas adelante de el
			}
		}
	}
	// setter y getter del gancho
	public function SetGolpeFuerte(fortachon:Bool){
		golpeFuerte = fortachon;
	}
	public function GetGolpeFuerte(){
		return golpeFuerte;
	}
}