package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class DropFalling extends Drops{ // hereda del drop de dinero
	private var broken:Bool = false; // comprueba que la caja que lo "contiene" esta rota
	private var gravito:Int; // esto sirve para que solamente se ejecute la gravedad una vez y no la mande abajo del piso
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		gravito = 0;
	}
	public function SetBroken(roto:Bool){
		broken = roto;
	}
	public function GetBroken(){
		return broken;
	}
	public function Gravity() {
		if (broken == true){ // si se rompio la caja, el objeto cae
			acceleration.y = 10;
		}
	}
	override public function update(elapsed:Float):Void{
		Gravity(); // igual, la gravedad siempre la trabajara este drop, nunca se ira de aqui
	}
}