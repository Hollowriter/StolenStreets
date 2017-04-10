package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;

class Drops extends FlxSprite{
	private var puntos:Int = 0;
	private var valor:Int = FlxG.random.int(0, 3);
	public function Juntado():Void{
		Reg.guita += puntos;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		switch (valor){
			case 0:
				makeGraphic(10, 10, FlxColor.ORANGE);
				puntos = 5;
			case 1:
				makeGraphic(10, 10, FlxColor.RED);
				puntos = 10;
			case 2: 
				makeGraphic(10, 10, FlxColor.BLUE);
				puntos = 25;
			case 3:
				makeGraphic(10, 10, FlxColor.GREEN);
				puntos = 50;
			default:
				makeGraphic(15, 15, FlxColor.WHITE);
				puntos = 1;	
		}
	}
	
	
}