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

/**
 * ...
 * @author ...
 */
class CharSelectState extends FlxState{
	private var orden:FlxText;
	private var opcion1:FlxText;
	private var opcion2:FlxText;
	override public function create(){
		orden = new FlxText();
		opcion1 = new FlxText();
		opcion2 = new FlxText();
		orden.text = "Choose your character";
		opcion1.text = "Mili";
		opcion2.text = "Sofia";
		orden.text = FlxColor.CYAN;
		opcion1.color = FlxColor.PINK;
		opcion2.color = FlxColor.PURPLE;
		orden.scale.x = 4;
		orden.scale.y = 4;
		opcion1.scale.x = 2;
		opcion1.scale.y = 2;
		opcion2.scale.x = 2;
		opcion2.scale.y = 2;
		orden.x = (FlxG.width / 2) - orden.scale.x;
		orden.y = (FlxG.height / 4) - orden.scale.y;
		opcion1.x = (FlxG.width / 2) - opcion1.scale.x;
		opcion1.y = (FlxG.height / 4) - opcion1.scale.y;
		opcion2.x = (FlxG.width / 2) - opcion2.scale.x;
		opcion2.y = (FlxG.height / 4) - opcion2.scale.y;
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
	}
}