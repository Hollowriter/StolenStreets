package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import sprites.TitleScreen;
import source.Reg;

class MenuState extends FlxState{
	private var comando:FlxText; //Toca Enter para empezar el Juego
	private var seinFondo:TitleScreen;
	private var camarita:FlxCamera;
	override public function create():Void{
		super.create();
		camarita = new FlxCamera(1, 1);
		comando = new FlxText();
		comando.text = "PRESS ENTER TO PLAY";
		comando.color = 0xB2FFB5;
		comando.scale.x = 3.5;
		comando.scale.y = 3.5;
		comando.x = (FlxG.width / 2) - comando.scale.x;
		comando.y = (FlxG.height / 1.5) - comando.scale.y;
		comando.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		comando.scrollFactor.set(0, 0);
		comando.visible = true;
		seinFondo = new TitleScreen(350, 50);
		seinFondo.scale.set(2, 2);
		add(seinFondo);
		add(comando);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		/*FlxCamera.defaultCameras = [FlxG.camera];
		seinFondo.cameras = [camarita];*/
		if (FlxG.keys.justPressed.ENTER){
			Reg.Personaje = true;
			FlxG.switchState(new CharSelectState());
			Reg.numlvl = 1;
		}
		if (FlxG.keys.justPressed.SHIFT){
			Reg.Personaje = false;
			FlxG.switchState(new CharSelectState());
			Reg.numlvl = 2;
		}
	}
}
