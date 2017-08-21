package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;
import sprites.GuiaEnemigo;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class EnemigoSaltador extends BaseEnemigo{
	private var still:Bool;
	private var combo:Bool;
	private var golpesVarios:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.EnemigoSaltador__png, true, 50, 70);
		animation.add("Normal", [0, 1, 2, 3, 4], 4, true);
		animation.add("Caminar", [5, 6, 7, 8, 9, 10, 11], 4, true);
		animation.add("Lanzado", [15, 16, 17, 18]], 6, false);
		animation.add("Pegar", [12, 13], 6, false);
		animation.add("Ouch", [22, 22, 22], 4, false);
		animation.add("Saltar", [14, 14, 14], 4, false);
		animation.add("Caido", [24, 25, 26], 4, false);
		animation.add("CaidaLibre", [14], 2, true);
		animation.play("Normal");
		vidaEnemiga = Reg.vidaEnemiga;
		still = false;
		combo = false;
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		guia = new GuiaEnemigo(x, y);
		timer = 0;
		comboTimer = 0;
		golpesVarios = 0;
		isHurt = source.EstadoEnemigo.Normal;
		saltito = false;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
}