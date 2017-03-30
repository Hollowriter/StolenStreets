package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Enemigo;
import sprites.Golpejugador;
import sprites.Jugador;
import sprites.PlataformaFlotante;
import sprites.PlataformaPrincipal;
import sprites.BaseEnemigo;
import sprites.Enemigo1;

class PlayState extends FlxState{
	private var Mili:Jugador;
	private var Chico:Enemigo;
	private var Platform:PlataformaPrincipal;
	private var testFloatingPlatform:PlataformaFlotante;
	private var testFloatingPlatform1:PlataformaFlotante;
	// private var golpe:Golpe;
	// private var auch:Int = 10; //descomentar si querer testear vida de jugador;
	private var life:Int;
	private var ay:Int = 25; //descomentar si querer testear vida de jugador;
	private var chico1:Enemigo1; //nueva clase enemigo
	override public function create():Void{
		super.create();
		Mili = new Jugador(30, 30);
		Chico = new Enemigo(70, 30);
		chico1 = new Enemigo1(90, 30); //nueva clase enemigo
		Platform = new PlataformaPrincipal(0, 300);
		testFloatingPlatform = new PlataformaFlotante(300, 200);
		testFloatingPlatform1 = new PlataformaFlotante(50, 200);
		// golpe = new Golpe();
		add(Mili);
		add(Chico);
		add(Platform);
		add(testFloatingPlatform);
		add(testFloatingPlatform1);
		testFloatingPlatform1.frenarHorizontal();
		add(chico1);
		add(Mili.getGolpear());
		/*golpe.add(Mili.getGolpear());*/
		/*golpes.add(Chico.getPunch());*/
		// add(golpe);
		// add(golpes.members[1]);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		FlxG.collide(Mili, Platform);
		FlxG.collide(Chico, Platform);
		FlxG.collide(chico1, Platform);
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform.y)
			FlxG.collide(Mili, testFloatingPlatform);
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform1.y) //Mas adelante estos if van a ser uno solo.
			FlxG.collide(Mili, testFloatingPlatform1);
		FlxG.collide(Chico, testFloatingPlatform);
		FlxG.collide(Chico, testFloatingPlatform);
		/*Por aca todo esto se puede sacar del playstate*/
		/*if (FlxG.keys.justPressed.L){
			life = Mili.getVida();
			life-= auch;
			Mili.setVida(life);
		}*/
		/*if (FlxG.keys.justPressed.K){
			life = Mili.getVida();
			life -= ay;
			Mili.setVida(life);
		}*/  //Prueba la vida;
		// Mili.playerMovement();
		// Mili.golpear();
		// Mili.combo();
		// Mili.pain();
		/*Por aca todo esto se puede sacar del playstate*/ /*Benja responde: Por ahora dejemoslo. Al menos por unos dias*/
		Mili.grab(Chico);
		Mili.salto();
		Chico.enemyMovement(Mili);
		// Chico.atacar(); // esto se puede sacar del playstate
		Chico.thyPain(Mili);
		Mili.getGolpear().zasEnTodaLaBoca(Chico);
		// golpes.members[1].zasEnTodaLaBoca(Mili, Chico);
		//En caso que el personaje se quede sin vidas y muera;
		if (FlxG.keys.justPressed.R){
			FlxG.resetState();
		}
	}
}