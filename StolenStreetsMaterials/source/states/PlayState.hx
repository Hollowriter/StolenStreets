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
import sprites.DropsVida;
import sprites.Obstaculo;
import sprites.DropFalling;

class PlayState extends FlxState{
	private var Mili:Jugador; // jugador
	private var Plata = new FlxTypedGroup<Drops>(2); // dinero
	private var Botiquin = new FlxTypedGroup<DropsVida>(2); // botiquines
	// private var PlataCaida = new FlxTypedGroup<DropFalling>(2); // dinero con gravedad (prueba)
	private var cantM:Int = 2; // cantidad de prueba para el array de Drops
	private var Chico:Enemigo; // enemigo de prueba (Reemplazar cuando la nueva clase este terminada)
	private var Platform:PlataformaPrincipal; // plataforma de prueba solida
	// plataformas flotantes
	private var testFloatingPlatform:PlataformaFlotante;
	private var testFloatingPlatform1:PlataformaFlotante;
	// plataformas flotantes
	private var Cajas = new FlxTypedGroup<Obstaculo>(2);
	private var trampolin:Trampolin; // plataforma de salto
	private var funca:Bool = false; // esto no se que es, por favor explicar
	private var puntaje:FlxText; // HUD puntaje
	private var vida:FlxText; // HUD vida
	private var money:FlxText; //Buena cancion de Pink Floyd // HUD dinero
	private var lifes:FlxText;
	// private var golpe:Golpe; (Clase muerta)
	// private var auch:Int = 10; //descomentar si querer testear vida de jugador; (sin usar)
	private var life:Int; // vida
	// private var ay:Int = 25; //descomentar si querer testear vida de jugador; (sin usar)
	private var chico1:Enemigo1; //nueva clase enemigo (bajo test)
	// private var hechos:Int = 1; (sin usar)
	override public function create():Void{
		super.create();
		Mili = new Jugador(30, 30);
		Cajas.members[0] = new Obstaculo(200, 200);
		Cajas.members[1] = new Obstaculo(300, 200);
		Plata.members[0] = new Drops(300, 100);
		Plata.members[1] = new Drops(350, 100);
		// PlataCaida.members[0] = new DropFalling(400, 100);
		// PlataCaida.members[1] = new DropFalling(450, 100); // ambas son de prueba
		Botiquin.members[0] = new DropsVida(400, 150);
		Botiquin.members[1] = new DropsVida(450, 150);
		Chico = new Enemigo(70, 30);
		chico1 = new Enemigo1(90, 30); //nueva clase enemigo (bajo test)
		Platform = new PlataformaPrincipal(0, 350);
		testFloatingPlatform = new PlataformaFlotante(300, 250);
		testFloatingPlatform1 = new PlataformaFlotante(50, 250); 
		// crea el HUD del dinero
		lifes = new FlxText (150, 30);
		lifes.text = "LIFE?";
		lifes.color = 0xB2FFB5;
		lifes.scale.x = 2;
		lifes.scale.y = 2;
		lifes.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		lifes.scrollFactor.set(0, 0);
		lifes.visible = true;
		money = new FlxText (150, 1);
		money.text = "MONEY?";
		money.color = 0x00FFFF;
		money.scale.x = 2;
		money.scale.y = 2;
		money.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		money.scrollFactor.set(0, 0);
		money.visible = true;
		// crea el HUD del dinero
		trampolin = new Trampolin(400, 250);
		// crea el HUD de los puntos
		puntaje = new FlxText(20, 1);
		puntaje.color = 0xefff0a;
		puntaje.text = "SCORE?";
		puntaje.scale.x = 2;
		puntaje.scale.y = 2;
		puntaje.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		puntaje.scrollFactor.set(0, 0);
		puntaje.visible = true;
		// crea el HUD de los puntos
		// crea el HUD de la vida
		vida = new FlxText(30, 30);
		vida.color = 0x800000;
		vida.text = "HEALTH?";
		vida.scale.x = 2;
		vida.scale.y = 2;
		vida.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff77aacc);
		vida.scrollFactor.set(0, 0);
		vida.visible = true;
		// crea el HUD de la vida
		add(Plata.members[0]);
		add(Plata.members[1]);
		// add(PlataCaida.members[0]);
		// add(PlataCaida.members[1]);
		add(Botiquin.members[0]);
		add(Botiquin.members[1]);
		add(Cajas.members[0]);
		add(Cajas.members[1]);
		if (Cajas.members[0].GetDrop() != null){ // si es una caja indestructible, no va a agregar un objeto nulo que no existe
			add(Cajas.members[0].GetDrop());
			trace('true');
		}
		if (Cajas.members[1].GetDrop() != null){ // si es una caja indestructible, no va a agregar un objeto nulo que no existe
			add(Cajas.members[1].GetDrop());
			trace('true2');
		}
		add(puntaje);
		add(money);
		add(vida);
		add(lifes);
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
		// HUD
		lifes.text = ("LIFE: " + Mili.GetLife());
		money.text = ("MONEY: $" + Reg.guita);
		puntaje.text = ("SCORE: " + Reg.puntaje);
		vida.text = ("HEALTH: " + Mili.GetVida());
		// HUD
		FlxG.collide(Mili, Platform);
		FlxG.collide(Cajas.members[0], Platform);
		FlxG.collide(Cajas.members[1], Platform);
		FlxG.collide(Cajas.members[1], Cajas.members[0]);
		// FlxG.collide(PlataCaida.members[0], Platform);
		// FlxG.collide(PlataCaida.members[1], Platform);
		/*FlxG.collide(Cajas.members[0], Mili);
		FlxG.collide(Mili,Cajas.members[1]);*/
		//FlxG.collide(Chico, Cajas.members[0]);
		//FlxG.collide(Cajas.members[1], chico1); // Colisiones de las cajas con Mili, ¿Seran las de los efectos raros?
		FlxG.collide(Chico, Platform);
		FlxG.collide(chico1, Platform);
		/*testeando los dropeos de las cajas destruibles*/
		if (Cajas.members[0].GetDrop() != null){
			FlxG.collide(Cajas.members[0].GetDrop(), Platform);
		}
		if (Cajas.members[1].GetDrop() != null){
			FlxG.collide(Cajas.members[1].GetDrop(), Platform);
		}
		/*testeando los dropeos de las cajas destruibles*/
		// Collider complicado para las plataformas flotantes de colision con el jugador
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform.y)
			FlxG.collide(Mili, testFloatingPlatform);
		if ((Mili.y + (Mili.height / 2)) < testFloatingPlatform1.y) //Mas adelante estos if van a ser uno solo.
			FlxG.collide(Mili, testFloatingPlatform1);
		// Collider complicado para las plataformas flotantes de colision con el jugador
		FlxG.collide(Chico, testFloatingPlatform);
		FlxG.collide(Chico, testFloatingPlatform);
		// Collider complicado para las plataformas trampolin de colision con el jugador
		if ((Mili.y + (Mili.height / 2)) < trampolin.y){
			if (FlxG.collide(Mili, trampolin)){
				Mili.SaltoTrampolin();
			}
		}
		// Collider complicado para las plataformas trampolin de colision con el jugador
		// Overlap del jugador con los objetos recolectables
		for (i in 0...cantM){
			if (FlxG.overlap(Mili, Plata.members[i])){
				Plata.members[i].Juntado();
				Plata.members[i].kill();
			}
		}
		for (b in 0...cantM){
			if (FlxG.overlap(Mili, Botiquin.members[b])){
				Botiquin.members[b].Curado(Mili);
				Botiquin.members[b].kill();
			}
		}
		/*dropeo de las cajas*/
		for (t in 0...cantM){
			if (Cajas.members[t].GetDrop() != null){
				if (FlxG.overlap(Mili, Cajas.members[t].GetDrop())){
					Cajas.members[t].GetDrop().Juntado();
					Cajas.members[t].GetDrop().kill();
				}
			}
		}
		/*dropeo de las cajas*/
		// Overlap del jugador con los objetos recolectables
		/*Por aca todo esto se puede sacar del playstate*/ /*Benja responde: Por ahora dejemoslo. Al menos por unos dias*/
		Mili.Agarrar(Chico);
		Mili.Salto();
		Chico.MovimientoDelEnemigo(Mili);
		// Chico.Atacar(); // esto se puede sacar del playstate
		Chico.DolorDelEnemigo(Mili);
		Mili.GetGolpear().ColisionDelGolpe(Chico);
		for (o in 0...cantM){
			Mili.GetGolpear().ColisionconCaja(Cajas.members[o], Mili);
		}
		Chico.GetGolpeEnemigo().ColisionDelGolpeEnemigo(Mili);
		//En caso que el personaje se quede sin vidas y muera... Reinicia el juego
		if (FlxG.keys.justPressed.R){
			FlxG.resetState();
			Reg.guita = 0;
			Reg.puntaje = 0;
		}
	}
}