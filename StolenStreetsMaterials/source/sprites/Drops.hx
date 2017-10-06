package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
/**
 * ...
 * @author MorenaMontero(Inicial)
 */
class Drops extends FlxSprite{
	private var puntos:Int; // cantidad de puntos que da el objeto
	private var valor:Int = FlxG.random.int(0, 3); // decide que tipo de moneda aparecera
	private var creado:Bool = true;
	private var recolectado:Bool = false;
	public function Juntado():Void{
		Reg.guita += puntos;
		recolectado = true;
	}
	public function Recoleccion(){
		return recolectado;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		// lista de tipos de monedas
		loadGraphic(AssetPaths.Items__png, true, 15, 19);
		animation.add("Vueltas", [0, 1, 2, 3, 4], 5, true);
		animation.play("Vueltas");
		puntos = 5;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}
}