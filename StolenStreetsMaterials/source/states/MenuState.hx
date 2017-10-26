package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import sprites.TitleScreen;
import states.PlayState;
import source.Reg;

class MenuState extends FlxState{
	private var comando:FlxText; //Toca Enter para empezar el Juego
	private var seinFondo:TitleScreen;
	private var camarita:FlxCamera;
	override public function create():Void{
		super.create();
		camarita = new FlxCamera(1, 1);
		comando = new FlxText();
		comando.setFormat(AssetPaths.StolenStreet_Regular__ttf, 14);
		comando.text = "PRESS ENTER TO START";
		comando.color = 0xFFFFFFF;
		comando.scale.x = 2;
		comando.scale.y = 2;
		comando.x = (FlxG.width / 2.50) - comando.scale.x;
		comando.y = (FlxG.height / 1.45) - comando.scale.y;
		comando.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST, 0xFF0000FF);
		comando.scrollFactor.set(0, 0);
		comando.visible = true;
		seinFondo = new TitleScreen(350, 45);
		seinFondo.scale.set(2, 1.7);
		add(seinFondo);
		add(comando);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		/*FlxCamera.defaultCameras = [FlxG.camera];
		seinFondo.cameras = [camarita];*/
		if (FlxG.keys.justPressed.ENTER){
			FlxG.switchState(new CharSelectState());
			Reg.numlvl = 1;
			Reg.score = 0;
			Reg.puntaje = 0;
			Reg.enemigosMuertos = 0;
		}
		else if (FlxG.keys.justPressed.SHIFT){
			FlxG.switchState(new CharSelectState());
			Reg.numlvl = 3;
			Reg.score = 0;
			Reg.puntaje = 0;
			Reg.enemigosMuertos = 0;
		}
	}
}
