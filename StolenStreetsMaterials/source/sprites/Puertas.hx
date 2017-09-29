package sprites;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author ...
 */
class Puertas extends FlxSprite 
{
	var enemigosAAsesinar:Int;
	var enemigosPedidos:Int = 0;
	var empujarJugador:Bool;
	var conseguido:Bool = false;
	var puertaAbierta:Bool = false;
	var puertaDesruida:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PuertayTrampolin__png, true, 15, 75);
		animation.add("Cerrada", [10], 1, true);
		animation.add("Abriendose", [10, 11, 12, 13], 4, false);
		animation.play("Cerrada");
		immovable = true;
		enemigosAAsesinar = 1;
	}
	public function SetEnemigosAAsesinar(cant:Int){
		enemigosAAsesinar = cant;
		enemigosPedidos = enemigosAAsesinar;
	}
	public function GetEnemigosPedidos(){
		return enemigosPedidos;
	}
	public function CheckeodePuertas(){
		if (enemigosAAsesinar <= Reg.enemigosMuertos && animation.getByName("Abriendose").finished){
			puertaDesruida = true;
			kill();
		}
	}
	public function PuertaFuera(){
		return puertaDesruida;
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		if (enemigosAAsesinar <= Reg.enemigosMuertos && conseguido == false){
			animation.play("Abriendose");
			conseguido = true;
		}
		if (enemigosAAsesinar > Reg.enemigosMuertos){
			animation.play("Cerrada");
			conseguido = false;
		}
	}
}