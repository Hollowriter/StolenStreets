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
import source.Reg;
import sprites.Trampolin;

class PlayState extends FlxState{
	private var Mili:Jugador;
	private var Chico:Enemigo;
	private var Platform:PlataformaPrincipal;
	private var testFloatingPlatform:PlataformaFlotante;
	private var testFloatingPlatform1:PlataformaFlotante;
	private var trampolin:Trampolin;
	private var funca:Bool = false;
	private var puntaje:FlxText;
	private var vida:FlxText;
	// private var golpe:Golpe;
	// private var auch:Int = 10; //descomentar si querer testear vida de jugador;
	private var life:Int;
	private var ay:Int = 25; //descomentar si querer testear vida de jugador;
	private var chico1:Enemigo1; //nueva clase enemigo
	private var hechos:Int = 1;
	override public function create():Void{
		super.create();
		Mili = new Jugador(30, 30);
		Chico = new Enemigo(70, 30);
		chico1 = new Enemigo1(90, 30); //nueva clase enemigo
		Platform = new PlataformaPrincipal(0, 300);
		testFloatingPlatform = new PlataformaFlotante(300, 200);
		testFloatingPlatform1 = new PlataformaFlotante(50, 200); 
		trampolin = new Trampolin(400, 200);
		puntaje = new FlxText(20, 1);
		puntaje.color = 0xefff0a;
		puntaje.text = "SCORE?";
		puntaje.scale.x = 2;
		puntaje.scale.y = 2;
		puntaje.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		puntaje.scrollFactor.set(0, 0);
		puntaje.visible = true;
		vida = new FlxText(20, 30);
		vida.color = 0x800000;
		vida.text = "LIFE?";
		vida.scale.x = 2;
		vida.scale.y = 2;
		vida.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff77aacc);
		vida.scrollFactor.set(0, 0);
		vida.visible = true;
		add(puntaje);
		add(vida);
		add(Mili);
		add(Chico);
		add(Platform);
		add(testFloatingPlatform);
		add(testFloatingPlatform1);
		testFloatingPlatform1.frenarHorizontal();
		add(chico1);
		add(Mili.GetGolpear());
		add(Chico.GetGolpeEnemigo());
		add(trampolin);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		puntaje.text = ("SCORE: " + Reg.puntaje);
		vida.text = ("LIFE: " + Mili.GetVida());
		FlxG.collide(Mili, Platform);
		FlxG.collide(Chico, Platform);
		FlxG.collide(chico1, Platform);
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform.y)
			FlxG.collide(Mili, testFloatingPlatform);
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform1.y) //Mas adelante estos if van a ser uno solo.
			FlxG.collide(Mili, testFloatingPlatform1);
		FlxG.collide(Chico, testFloatingPlatform);
		FlxG.collide(Chico, testFloatingPlatform);
		if ((Mili.y + (Mili.height / 2)) < trampolin.y){
			if (FlxG.collide(Mili, trampolin)){
				Mili.SaltoTrampolin();
			}
		}
		/*Por aca todo esto se puede sacar del playstate*/ /*Benja responde: Por ahora dejemoslo. Al menos por unos dias*/
		Mili.Agarrar(Chico);
		Mili.Salto();
		Chico.MovimientoDelEnemigo(Mili);
		// Chico.Atacar(); // esto se puede sacar del playstate
		Chico.DolorDelEnemigo(Mili);
		Mili.GetGolpear().ColisionDelGolpe(Chico);
		Chico.GetGolpeEnemigo().ColisionDelGolpeEnemigo(Mili);
		//En caso que el personaje se quede sin vidas y muera;
		if (FlxG.keys.justPressed.R){
			FlxG.resetState();
		}
	}
}