package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Enemigo;
import sprites.Golpe;
import sprites.Jugador;
import sprites.PlataformaPrincipal;

class PlayState extends FlxState{
	private var Mili:Jugador;
	private var Chico:Enemigo;
	private var Platform:PlataformaPrincipal;
	private var golpes:FlxTypedGroup<Golpe>;
	override public function create():Void{
		super.create();
		Mili = new Jugador(30, 30);
		Chico = new Enemigo(70, 30);
		Platform = new PlataformaPrincipal(0, 300);
		golpes = new FlxTypedGroup<Golpe>();
		add(Mili);
		add(Chico);
		add(Platform);
		golpes.add(Mili.getGolpear());
		golpes.add(Chico.getPunch());
		add(golpes.members[0]);
		add(golpes.members[1]);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		FlxG.collide(Mili, Platform);
		FlxG.collide(Chico, Platform);
		Mili.playerMovement();
		Mili.golpear();
		Mili.combo();
		Mili.pain();
		Chico.enemyMovement(Mili);
		Chico.atacar();
		Chico.thyPain();
		golpes.members[0].zasEnTodaLaBoca(Mili, Chico);
		golpes.members[1].zasEnTodaLaBoca(Mili, Chico);
	}
}