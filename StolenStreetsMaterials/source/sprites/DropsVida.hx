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
		if (overlaps(enfermito) && recolectado == false){
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
			kill();
		}
	}
	public function Recoleccion(){
		return recolectado;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Items__png, true, 18, 19);
		animation.add("Caramelo", [4], 1, true);
		animation.play("Caramelo");
		vidaExtra = false;
		salud = 10;
	}
	
}