package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import states.PlayState;
import source.Reg;


class InstructionsState extends FlxState{
	private var enPagina1:Bool = true;
	private var pagina1:FlxSprite;
	private var pagina2:FlxSprite;
	private var musica:FlxSound;
	override public function create():Void{
		super.create();
		musica = new FlxSound();
		musica.loadEmbedded(AssetPaths.break_clubstar_zone__ogg, true);
		musica.volume = 0.1;
		musica.play();
		pagina1 = new FlxSprite();
		pagina2 = new FlxSprite();

		if(Reg.sofiElegida == false)
			pagina1.loadGraphic(AssetPaths.guia1mili__png, true, 940, 480);
		else if(Reg.sofiElegida == true)
			pagina1.loadGraphic(AssetPaths.guia1sofi__png, true, 940, 480);
		if (Reg.sofiElegida == false)
			pagina2.loadGraphic(AssetPaths.guia2mili__png, true, 940, 480);
		else if(Reg.sofiElegida == true)
			pagina2.loadGraphic(AssetPaths.guia2sofi__png, true, 940, 480);
		add(pagina1);

	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
			if (FlxG.keys.justPressed.ENTER && enPagina1 == true){
			add(pagina2);
			enPagina1 = false;
			}
		else if (FlxG.keys.justPressed.ENTER && enPagina1 == false)
			{
				enPagina1 = true;
				musica.stop();
				FlxG.switchState(new PlayState());
			}
	}
}
