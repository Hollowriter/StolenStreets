package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import source.Reg;
import flixel.animation.FlxAnimation;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class CharSelectState extends FlxState{
	private var orden:FlxText;
	private var opcion1:FlxText;
	private var opcion2:FlxText;
	private var mili:FlxSprite;
	private var sofi:FlxSprite;
	
	override public function create(){
		mili = new FlxSprite();
		sofi = new FlxSprite();
		mili.loadGraphic(AssetPaths.MiliCS__png);
		sofi.loadGraphic(AssetPaths.SofiCS__png);
		orden = new FlxText();
		opcion1 = new FlxText();
		opcion2 = new FlxText();
		orden.setFormat(AssetPaths.StolenStreet_Regular__ttf, 10);
		opcion1.setFormat(AssetPaths.StolenStreet_Regular__ttf, 7);
		opcion2.setFormat(AssetPaths.StolenStreet_Regular__ttf, 7);
		orden.text = "CHOOSE YOUR CHARACTER";
		opcion1.text = "PRESS LEFT TO PLAY AS MILI";
		opcion2.text = "PRESS RIGHT TO PLAY AS SOFIA";
		orden.color = FlxColor.CYAN;
		opcion1.color = FlxColor.PINK;
		opcion2.color = FlxColor.PURPLE;
		orden.scale.x = 4;
		orden.scale.y = 4;
		opcion1.scale.x = 2;
		opcion1.scale.y = 2;
		opcion2.scale.x = 2;
		opcion2.scale.y = 2;
		orden.x = (FlxG.width / 2.25) - orden.scale.x;
		orden.y = (FlxG.height / 10) - orden.scale.y;
		opcion1.x = (FlxG.width / 3.5) - opcion1.scale.x;
		opcion1.y = (FlxG.height / 3) - opcion1.scale.y;
		opcion2.x = (FlxG.width / 1.5) - opcion2.scale.x;
		opcion2.y = (FlxG.height / 3) - opcion2.scale.y;
		mili.x = opcion1.x;
		sofi.x = opcion2.x;
		mili.scale.x *= 1.5;
		sofi.scale.x *= 1.5;
		mili.scale.y *= 1.5;
		sofi.scale.y *= 1.5;
		mili.y = opcion1.y + 75;
		sofi.y = opcion2.y + 75;
		orden.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		opcion1.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		opcion2.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		orden.scrollFactor.set(0, 0);
		opcion1.scrollFactor.set(0, 0);
		opcion2.scrollFactor.set(0, 0);
		orden.visible = true;
		opcion1.visible = true;
		opcion2.visible = true;
		add(orden);
		add(opcion1);
		add(opcion2);
		add(mili);
		add(sofi);
	}
		override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (FlxG.keys.justPressed.LEFT){
			 Reg.sofiElegida = false;
			 FlxG.switchState(new InstructionsState());
		 }
		if (FlxG.keys.justPressed.RIGHT){
			Reg.sofiElegida = true;
			FlxG.switchState(new InstructionsState());
		}
	}
}