package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Drops;
import sprites.Golpejugador;
import sprites.Jugador;
import sprites.PlataformaFlotante;
//import sprites.PlataformaPrueba;
import sprites.BaseEnemigo;
import sprites.Enemigo1;
import source.Reg;
import sprites.SueloPeligroso;
import sprites.Trampolin;
import sprites.DropsVida;
import sprites.Obstaculo;
import sprites.DropFalling;
import sprites.SueloPeligroso;
import sprites.PisoLetal;
import sprites.Instanciador;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class PlayState extends FlxState{
	private var Plata = new FlxTypedGroup<Drops>(2); // dinero
	private var Botiquin = new FlxTypedGroup<DropsVida>(2); // botiquines
	// private var PlataCaida = new FlxTypedGroup<DropFalling>(2); // dinero con gravedad (prueba)
	private var cantM:Int = 2; // cantidad de prueba para el array de Drops
	// plataformas flotantes
	//private var plataforma:PlataformaPrueba;
	// plataformas flotantes
	private var Cajas:Obstaculo;
	private var funca:Bool = false; // esto no se que es, por favor explicar
	private var puntaje:FlxText; // HUD puntaje
	private var vida:FlxText; // HUD vida
	private var money:FlxText; //Buena cancion de Pink Floyd // HUD dinero
	private var lifes:FlxText;
	private var life:Int; // vida
	private var pinches:SueloPeligroso;
	private var instanciando:Instanciador;
	// private var chico1:BaseEnemigo; //nueva clase enemigo (bajo test)
	//EL nivel
	var ogmoLoader:FlxOgmoLoader;
	var tileMap:FlxTilemap;
	var tmpMap:TiledObjectLayer;
	override public function create():Void{
		super.create();
		instanciando = new Instanciador();
		//plataforma = new PlataformaPrueba(30, 300);
		//Cajas.members[0] = new Obstaculo(200, 200);
		//Cajas.members[1] = new Obstaculo(300, 200);
		//Plata.members[0] = new Drops(300, 100);
		//Plata.members[1] = new Drops(350, 100);
		// PlataCaida.members[0] = new DropFalling(400, 100);
		// PlataCaida.members[1] = new DropFalling(450, 100); // ambas son de prueba
		//Botiquin.members[0] = new DropsVida(400, 150);
		//Botiquin.members[1] = new DropsVida(450, 150);
		// chico1 = new Enemigo1(90, 30); //nueva clase enemigo (enemigo de testeo)
		//testFloatingPlatform = new PlataformaFlotante(300, 250);
		//testFloatingPlatform1 = new PlataformaFlotante(50, 250); 
		//pinches = new SueloPeligroso(500, 290);
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
		//Grupos de objetos para Ogmo
		Reg.Players = new FlxTypedGroup<Jugador>();
		Reg.Enemigos = new FlxTypedGroup<BaseEnemigo>();
		Reg.PlataformasFlotantes = new FlxTypedGroup<PlataformaFlotante>();
		Reg.Trampolines = new FlxTypedGroup<Trampolin>();
		Reg.Cajitas = new FlxTypedGroup<Obstaculo>();
		Reg.Pinches = new FlxTypedGroup<SueloPeligroso>();
		Reg.Monedas = new FlxTypedGroup<Drops>();
		Reg.Botiquines = new FlxTypedGroup<DropsVida>();
		Reg.PisosLetales = new FlxTypedGroup<PisoLetal>();
		ogmoLoader = new FlxOgmoLoader(AssetPaths.Nivel11__oel);
		tileMap = ogmoLoader.loadTilemap(AssetPaths.tilesetnivel1__png, 20, 20, "tilesets");
		ogmoLoader.loadEntities(entityCreator, "entidades");
		//tileMap.follow();
		FlxG.worldBounds.set(0, 0, tileMap.width, tileMap.height);
		for (i in 0...27){
			if (i == 0 || i == 15 || i == 16 || i == 30 || i == 31){ //14 15 29 30
				// trace("inside");
				tileMap.setTileProperties(i, FlxObject.NONE);
			}
			else{
				// trace("inside");
				tileMap.setTileProperties(i, FlxObject.ANY);
			}
		}
		add(tileMap);
		add(instanciando);
		// crea el HUD de la vida
		add(Reg.Monedas);
		add(Reg.Botiquines);
		add(Reg.Pinches);
		/*if (Cajas.members[0].GetDrop() != null){ // si es una caja indestructible, no va a agregar un objeto nulo que no existe
			add(Cajas.members[0].GetDrop());
			//trace('true');
		}*/
		/*if (Cajas.members[1].GetDrop() != null){ // si es una caja indestructible, no va a agregar un objeto nulo que no existe
			add(Cajas.members[1].GetDrop());
			//trace('true2');
		}*/
		add(puntaje);
		add(money);
		add(vida);
		add(lifes);
		add(Reg.Players);
		camera.follow(Reg.Players.members[0]);
		// add(chico1);
		add(Reg.Players.members[0].GetGolpear());
		//add(plataforma);	
		add(Reg.Enemigos);
		add(Reg.PlataformasFlotantes);
		add(Reg.Trampolines);
		add(Reg.Cajitas);
		add(Reg.PisosLetales);
		for (i in 0...(Reg.Enemigos.length)){
			add(Reg.Enemigos.members[i].GetGolpeEnemigo());
			// add(Reg.Enemigos.members[i].GetGuia());
		}
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// HUD
		lifes.text = ("LIFE: " + Reg.Players.members[0].GetLife());
		money.text = ("MONEY: $" + Reg.guita);
		puntaje.text = ("SCORE: " + Reg.puntaje);
		vida.text = ("HEALTH: " + Reg.Players.members[0].GetVida());
		// HUD
		for (i in 0...Reg.Cajitas.length){
			FlxG.collide(Reg.Cajitas.members[i], Reg.Players.members[0]);
			FlxG.collide(Reg.Cajitas.members[i], tileMap);
			for (b in 0...Reg.Cajitas.length){
				FlxG.collide(Reg.Cajitas.members[i], Reg.Cajitas.members[b]);
			}
		}
		for (a in 0...Reg.Pinches.length){
			FlxG.collide(Reg.Pinches.members[a], tileMap);
		}
		for (a in 0...Reg.Enemigos.length){
			Reg.Enemigos.members[a].GetGuia().HayPiso(tileMap);
		}
		// FlxG.collide(Reg.Players.members[0], plataforma);
		//Colision entre Mili y el tilemap
		if (FlxG.collide(Reg.Players.members[0], tileMap))
			Reg.Players.members[0].SetPosRespawn();
		for (v in 0...Reg.Pinches.length){
			if (FlxG.overlap(Reg.Players.members[0], Reg.Pinches.members[v])){
				Reg.Players.members[0].ColisiondeSP();
			}
		}
		// Collider complicado para las plataformas trampolin de colision con el jugador
		// Overlap del jugador con los objetos recolectables
		for (i in 0...Reg.Monedas.length){
			if (FlxG.overlap(Reg.Players.members[0], Reg.Monedas.members[i])){
				Reg.Monedas.members[i].Juntado();
			}
		}
		for (b in 0...Reg.Botiquines.length){
			if (FlxG.overlap(Reg.Players.members[0], Botiquin.members[b])){
				Reg.Botiquines.members[b].Curado(Reg.Players.members[0]);
			}
		}
		/*dropeo de las cajas*/
		for (t in 0...Reg.Cajitas.length){
			if (Reg.Cajitas.members[t].GetDrop() != null){
				if (FlxG.overlap(Reg.Players.members[0], Reg.Cajitas.members[t].GetDrop())){
					Reg.Cajitas.members[t].GetDrop().Juntado();
				}
			}
		}
		//Colision entre Mili y los trampolines
		for (i in 0...(Reg.Trampolines.members.length)){
			if ((Reg.Players.members[0].y + (Reg.Players.members[0].height / 2)) < Reg.Trampolines.members[i].y){
				if (FlxG.collide(Reg.Players.members[0], Reg.Trampolines.members[i])){
					Reg.Players.members[0].SaltoTrampolin();
				}
		}
		//Colision entre Mili y las plataformas flotantes
		for (i in 0...(Reg.PlataformasFlotantes.members.length)){
			if((Reg.Players.members[0].y + Reg.Players.members[0].height) <  (Reg.PlataformasFlotantes.members[i]).y +  Reg.PlataformasFlotantes.members[i].height)
			FlxG.collide(Reg.Players.members[0], Reg.PlataformasFlotantes.members[i]);
		}
		//COLISIONES ENTRE ENEMIGOS
		for (i in 0...(Reg.Enemigos.members.length)){
			for (j in 0...(Reg.Enemigos.members.length)){
				if (Reg.Enemigos.members[i].isOnScreen() && Reg.Enemigos.members[j].isOnScreen()){
					FlxG.collide(Reg.Enemigos.members[i], Reg.Enemigos.members[j]);
				}
			}
		}
		//COLISIONES DE LOS ENEMIGOS CON EL MAPA
		for(i in 0...(Reg.Enemigos.members.length)){
			FlxG.collide(Reg.Enemigos.members[i], tileMap);
			if (Reg.Enemigos.members[i].isTouching(FlxObject.ANY)){
				Reg.Enemigos.members[i].SetSaltito(false);
			}
			else{
				Reg.Enemigos.members[i].SetSaltito(true);
			}
		}
		//colision entre Mili y el piso letal
		for (i in 0...(Reg.PisosLetales.length)){
			if(FlxG.collide(Reg.Players.members[0], Reg.PisosLetales.members[i])){
			//if (FlxG.overlap(Reg.Players.members[0], Reg.PisosLetales.members[i])){
				Reg.Players.members[0].instaKill();
			}
			//}
		}
		Reg.Players.members[0].Salto();
		// colisiones de los enemigos
		for (i in 0...Reg.Enemigos.length){
			Reg.Players.members[0].GetGolpear().ColisionDelGolpe(Reg.Enemigos.members[i], Reg.Players.members[0]);
			Reg.Players.members[0].Agarrar(Reg.Enemigos.members[i]);
			Reg.Enemigos.members[i].DolorDelEnemigo(Reg.Players.members[0]);
			Reg.Enemigos.members[i].GetGolpeEnemigo().ColisionDelGolpeEnemigo(Reg.Players.members[0]);
			if (Reg.Players.members[0].GetGolpear().overlaps(Reg.Enemigos.members[i])){
				//trace("choco con " + i);
			}
		}
		for (o in 0...Reg.Cajitas.length){
			Reg.Players.members[0].GetGolpear().ColisionconCaja(Reg.Cajitas.members[o], Reg.Players.members[0]);
		}
		// Agarre de Mili (En proceso)
		/*for (m in 0...(Reg.Enemigos.length)){
			Reg.Players.members[0].Agarrar(Reg.Enemigos.members[m]);
		}*/
		//En caso que el personaje se quede sin vidas y muera... Reinicia el juego
		if (FlxG.keys.justPressed.R){
			FlxG.resetState();
			Reg.guita = 0;
			Reg.puntaje = 0;
			// trace(Reg.Enemigos.length);
		}
	}
	//Instanciador
		for (i in 0...Reg.Enemigos.length){
			instanciando.CrearEnemigo(Reg.Enemigos.members[i]);
		}
		for (j in 0...Reg.Trampolines.length){
			instanciando.CrearTrampolin(Reg.Trampolines.members[j]);
		}
		for (m in 0...Reg.PlataformasFlotantes.length){
			instanciando.CrearPlataformaFlotante(Reg.PlataformasFlotantes.members[m]);
		}
		for (l in 0...Reg.Cajitas.length){
			instanciando.CrearObstaculo(Reg.Cajitas.members[l]);
		}
		for (p in 0...Reg.Monedas.length){
			instanciando.CrearDrops(Reg.Monedas.members[p]);
		}
		for (b in 0...Reg.Botiquines.length){
			instanciando.CrearDropsVida(Reg.Botiquines.members[b]);
		}
		for (q in 0...Reg.Pinches.length){
			instanciando.CrearSueloPeligroso(Reg.Pinches.members[q]);
		}
		for (k in 0...Reg.PisosLetales.length){
			instanciando.CrearPisoLetal(Reg.PisosLetales.members[k]);
		}
	}
	private function entityCreator(entityName:String, entityData:Xml):Void{
		var entityStartX:Int = Std.parseInt(entityData.get("x"));
		var entityStartY:Int = Std.parseInt(entityData.get("y"));
		//	Me fijo qué tipo de entidad tengo que inicializar...
		switch(entityName){
			case "enemigo":
				Reg.Enemigos.add(new Enemigo1(entityStartX, entityStartY));
			case "plataformaflotante":
				Reg.PlataformasFlotantes.add(new PlataformaFlotante(entityStartX, entityStartY));
			case "trampolin":
				Reg.Trampolines.add(new Trampolin(entityStartX, entityStartY));
			case "jugador":
				Reg.Players.add(new Jugador(entityStartX, entityStartY));
			case "cajas":
				Reg.Cajitas.add(new Obstaculo(entityStartX, entityStartY));
			case "pinches":
				Reg.Pinches.add(new SueloPeligroso(entityStartX, entityStartY));
			case "monedas":
				Reg.Monedas.add(new Drops(entityStartX, entityStartY));
			case "botiquines":
				Reg.Botiquines.add(new DropsVida(entityStartX, entityStartY));
			case "pisoletal":
				Reg.PisosLetales.add(new PisoLetal(entityStartX, entityStartY));
		}
	}
}