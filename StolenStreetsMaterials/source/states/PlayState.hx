package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Drops;
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
	private var Plata = new FlxTypedGroup<Drops>(2);
	private var cantM:Int = 2;
	private var Chico:Enemigo;
	private var Platform:PlataformaPrincipal;
	private var testFloatingPlatform:PlataformaFlotante;
	private var testFloatingPlatform1:PlataformaFlotante;
	private var trampolin:Trampolin;
	private var funca:Bool = false;
	private var puntaje:FlxText;
	private var vida:FlxText;
	private var money:FlxText; //Buena cancion de Pink Floyd
	// private var golpe:Golpe;
	// private var auch:Int = 10; //descomentar si querer testear vida de jugador;
	private var life:Int;
	private var ay:Int = 25; //descomentar si querer testear vida de jugador;
	private var chico1:Enemigo1; //nueva clase enemigo
	private var hechos:Int = 1;
	override public function create():Void{
		super.create();
		Mili = new Jugador(30, 30);
		Plata.members[0] = new Drops(300, 100);
		Plata.members[1] = new Drops(350, 100);
		Chico = new Enemigo(70, 30);
		chico1 = new Enemigo1(90, 30); //nueva clase enemigo
		Platform = new PlataformaPrincipal(0, 350);
		testFloatingPlatform = new PlataformaFlotante(300, 250);
		testFloatingPlatform1 = new PlataformaFlotante(50, 250); 
		money = new FlxText (150, 1);
		money.text = "MONEY?";
		money.color = 0x00FFFF;
		money.scale.x = 2;
		money.scale.y = 2;
		money.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		money.scrollFactor.set(0, 0);
		money.visible = true;
		trampolin = new Trampolin(400, 250);
		puntaje = new FlxText(20, 1);
		puntaje.color = 0xefff0a;
		puntaje.text = "SCORE?";
		puntaje.scale.x = 2;
		puntaje.scale.y = 2;
		puntaje.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		puntaje.scrollFactor.set(0, 0);
		puntaje.visible = true;
		vida = new FlxText(30, 30);
		vida.color = 0x800000;
		vida.text = "HEALTH?";
		vida.scale.x = 2;
		vida.scale.y = 2;
		vida.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff77aacc);
		vida.scrollFactor.set(0, 0);
		vida.visible = true;
		add(Plata.members[0]);
		add(Plata.members[1]);
		add(puntaje);
		add(money);
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
		money.text = ("MONEY: $" + Reg.guita);
		puntaje.text = ("SCORE: " + Reg.puntaje);
		vida.text = ("HEALTH: " + Mili.GetVida());
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
		for (i in 0...cantM){
			if (FlxG.overlap(Mili, Plata.members[i])){
				Plata.members[i].Juntado();
				Plata.members[i].kill();
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
			Reg.guita = 0;
		}
	}
}