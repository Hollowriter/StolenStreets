package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxColor;
import source.Reg;

/**
 * ...
 * @author RodrigoDiazKlipphan(Igual afane de otro codigo)
 */
class DropsVida extends FlxSprite{
	private var salud:Int; // cantidad de salud que da el objeto
	private var vidaExtra:Bool; // si el random da una oportunidad extra
	private var valor:Int = FlxG.random.int(0, 12); // el tipo de valor que tendra
	private var recolectado:Bool = false;
	// te da la salud o la oportunidad extra
	public function Curado(enfermito:Jugador):Void{
		if (vidaExtra == false){ // si no es una oportunidad extra
			if (enfermito.GetVida() < Reg.VidaMili){ // y el jugador esta lastimado
				enfermito.SetVida(enfermito.GetVida() + salud); // lo cura
				if (enfermito.GetVida() > Reg.VidaMili){ // si se pasa de la cantidad de vida estandar
					enfermito.SetVida(Reg.VidaMili); // no dejarla pasar de ese valor
				}
			}
		}
		else if (vidaExtra == true){ // si es una oportunidad extra
			enfermito.SetLife(enfermito.GetLife() + 1); // se la otorga
		}
		recolectado = true;
	}
	public function Recoleccion(){
		return recolectado;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		// lista de tipos de botiquines
		if (valor >= 5 && valor <= 8){
			valor -= 5;
		}
		else if (valor > 8){
			valor -= 9;
		}
		switch (valor){ // el random decide cual de estos
			case 0: // botiquin rojo con poca recuperacion de slaud
				makeGraphic(30, 10, FlxColor.RED);
				vidaExtra = false;
				salud = 10;
			case 1: // botiquin rosa con recuperacion de salud media
				makeGraphic(30, 10, FlxColor.PINK);
				vidaExtra = false;
				salud = 25;
			case 2: // botiquin color lima con recuperacion excepcional de salud
				makeGraphic(30, 10, FlxColor.LIME);
				vidaExtra = false;
				salud = 50;
			case 3: // botiquin color cyan con recuperacion total de la salud
				makeGraphic(30, 10, FlxColor.CYAN);
				vidaExtra = false;
				salud = 100;
			case 4: // oportunidad extra en forma de botiquin azul
				makeGraphic(30, 10, FlxColor.BLUE);
				vidaExtra = true;
			default: // botiquin de emergencia de color blanco con recuperacion penosa (Para evitar errores)
				makeGraphic(35, 15, FlxColor.WHITE);
				vidaExtra = false;
				salud = 1;	
		}
	}
	
}