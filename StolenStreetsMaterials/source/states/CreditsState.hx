package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.addons.display.FlxBackdrop;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import states.PlayState;
import source.Reg;


class CreditsState extends FlxState{
	private var imagenCreditos:FlxSprite;
	private var musica:FlxSound;
	override public function create():Void{
		super.create();
		musica = new FlxSound();
		musica.loadEmbedded(AssetPaths.fast_campus_ending__ogg, true);
		musica.volume = 0.1;
		musica.play();
		imagenCreditos = new FlxSprite();
		imagenCreditos.loadGraphic(AssetPaths.creditos__png, true, 940, 480);
		add(imagenCreditos);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
			{
				musica.stop();
				FlxG.switchState(new MenuState());
			}
	}
}
