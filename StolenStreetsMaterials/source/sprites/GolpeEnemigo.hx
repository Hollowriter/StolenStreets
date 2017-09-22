package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import source.Reg;
import flixel.system.FlxSound;

/**
 * ...
 * @author RodrigoDiazKlipphan(inciial)
 */
class GolpeEnemigo extends FlxSprite{
	private var golpeFuerte:Bool; // check gancho
	private var ljug:Int; // para afectar al jugador
	private var sonidoDanio:FlxSound;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		makeGraphic(30, 11, FlxColor.BLUE);
		golpeFuerte = false;
		ljug = 0;
		sonidoDanio = new FlxSound();
		sonidoDanio.loadEmbedded(AssetPaths.enemypunch__wav);
		sonidoDanio.volume = 1;
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
			if (Ouch.GetMeHurt() == source.EstadoEnemigo.Normal){ // chequea que el personaje no haya recibido un golpe con anterioridad
				Ouch.SetCombo(0); // rompe el Combo
				Ouch.SetTime(0); // reinicia el timer
				Ouch.SetMeHurt(source.EstadoEnemigo.Lastimado); // lo lastima
				Ouch.velocity.x = 0; // y lo detiene un rato
				ljug = Ouch.GetVida(); // la variable almacena la vida del jugador
				if (!golpeFuerte) ljug += Reg.danioPunioNormal; // la resta
				else ljug += Reg.danioPunioFuerte; // la resta
				Ouch.SetVida(ljug); // y la setea
				sonidoDanio.play();
			}
		}
	}
	// colocacion del golpe enemigo
	public function PunietazoEnemigo(?atacante:BaseEnemigo = null, observando:Bool):Void{
		if (atacante != null){ // si el enemigo existe
			y = atacante.y + Reg.punietazoEnemigoPosVertical; // esta a la misma altura del enemigo
			if (observando == false){
				x = atacante.x + Reg.punietazoEnemigoDerecha; // pero mas adelante de el
			}
			else if (observando == true){
				x = atacante.x + Reg.punietazoEnemigoIzquierda; // pero mas adelante de el
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