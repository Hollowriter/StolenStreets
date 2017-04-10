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
 * @author ...
 */
class Obstaculo extends FlxSprite{
	private var Destructible:Bool = false;
	private var Danio:Int = 0;
	public function void destruir (){
		if (Destructible == true){
			Danio += 0;
			if (Danio == 3){
				kill();
				Reg.puntaje += 10;
			}
		}
	}
	public function new() {
		
	}
	
}