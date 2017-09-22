package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import source.Reg;

class MenuState extends FlxState{
	private var comando:FlxText; //Toca Enter para empezar el Juego
	override public function create():Void{
		super.create();
		comando = new FlxText();
		comando.text = "PRESS ENTER TO PLAY";
		comando.color = 0xB2FFB5;
		comando.scale.x = 5;
		comando.scale.y = 5;
		comando.x = (FlxG.width / 2) - comando.scale.x;
		comando.y = (FlxG.height / 4) - comando.scale.y;
		comando.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		comando.scrollFactor.set(0, 0);
		comando.visible = true;
		add(comando);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
		 {
			 Reg.Personaje = true;
			 FlxG.switchState(new PlayState());
		 }
		if (FlxG.keys.justPressed.SHIFT)
		{
			Reg.Personaje = false;
			FlxG.switchState(new PlayState());
		}
	}
}
