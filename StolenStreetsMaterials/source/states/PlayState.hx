package states;

import flash.media.Sound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Drops;
import sprites.DropsVidaBotiquin;
import sprites.DropsVidaHelado;
import sprites.EnemigoConBate;
import sprites.EnemigoSaltador;
import sprites.FondoDeNoche;
import sprites.Golpejugador;
import sprites.Jugador;
import sprites.PlataformaFlotante;
import sprites.BaseEnemigo;
import sprites.Enemigo1;
import source.Reg;
import sprites.SueloPeligroso;
import sprites.Trampolin;
import sprites.DropsVida;
import sprites.PisoLetal;
import sprites.PisoLetalGrande;
import sprites.Instanciador;
import sprites.CheckPoint;
import sprites.Puertas;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.VictoryPoint;

class PlayState extends FlxState{
	private var cantM:Int = 2; // cantidad de prueba para el array de Drops
	private var funca:Bool = false; // esto no se que es, por favor explicar
	private var vida:FlxText; // HUD vida
	private var puntajetext:FlxText; //Buena cancion de Pink Floyd // HUD dinero
	private var lives:FlxText;
	private var life:Int; // vida
	private var pinches:SueloPeligroso;
	private var instanciando:Instanciador;
	private var cpActivo:Int = -1;
	private var fondoNoche:FondoDeNoche;
	var ogmoLoader:FlxOgmoLoader;
	var tileMap:FlxTilemap;
	var tmpMap:TiledObjectLayer;
	var fondito:FlxBackdrop;
	var musica:FlxSound;

	override public function create():Void{
		super.create();
		musica = new FlxSound();
		if (Reg.numlvl == 1)
			musica.loadEmbedded(AssetPaths.musicaoficial__ogg, true);
		else if (Reg.numlvl == 2)
			musica.loadEmbedded(AssetPaths.imjustice__ogg, true);
		else
			musica.loadEmbedded(AssetPaths.demo__ogg, true);
		musica.volume = 0.1;
		instanciando = new Instanciador();
		lives = new FlxText (20, 60);
		lives.setFormat(AssetPaths.StolenStreet_Regular__ttf, 10);
		lives.text = "LIVES?";
		lives.color = 0xB2FFB5;
		lives.scale.x = 2;
		lives.scale.y = 2;
		lives.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		lives.scrollFactor.set(0, 0);
		lives.visible = true;
		puntajetext = new FlxText (30, 0);
		puntajetext.setFormat(AssetPaths.StolenStreet_Regular__ttf, 10);
		puntajetext.text = "SCORE?";
		puntajetext.color = 0x00FFFF;
		puntajetext.scale.x = 2;
		puntajetext.scale.y = 2;
		puntajetext.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff1abcc9);
		puntajetext.scrollFactor.set(0, 0);
		puntajetext.visible = true;
		vida = new FlxText(35, 30);
		vida.setFormat(AssetPaths.StolenStreet_Regular__ttf, 10);
		vida.color = 0x800000;
		vida.text = "HEALTH?";
		vida.scale.x = 2;
		vida.scale.y = 2;
		vida.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff77aacc);
		vida.scrollFactor.set(0, 0);
		vida.visible = true;
		Reg.Players = new FlxTypedGroup<Jugador>();
		Reg.Enemigos = new FlxTypedGroup<BaseEnemigo>();
		Reg.PlataformasFlotantes = new FlxTypedGroup<PlataformaFlotante>();
		Reg.Trampolines = new FlxTypedGroup<Trampolin>();
		Reg.Pinches = new FlxTypedGroup<SueloPeligroso>();
		Reg.Monedas = new FlxTypedGroup<Drops>();
		Reg.Caramelos = new FlxTypedGroup<DropsVida>();
		Reg.Helados = new FlxTypedGroup<DropsVidaHelado>();
		Reg.Botiquines = new FlxTypedGroup<DropsVidaBotiquin>();
		Reg.PisosLetales = new FlxTypedGroup<PisoLetal>();
		Reg.PisosLetalesGrandes = new FlxTypedGroup<PisoLetalGrande>();
		Reg.Checkpoints = new FlxTypedGroup<CheckPoint>();
		Reg.PuertasLimitadoras = new FlxTypedGroup<Puertas>();
		Reg.PuntoDeVictoria = new FlxTypedGroup<VictoryPoint>();
		fondoNoche = new FondoDeNoche();
		if (Reg.numlvl == 1)
			ogmoLoader = new FlxOgmoLoader(AssetPaths.Nivel11__oel);
		else if (Reg.numlvl == 2)
			ogmoLoader = new FlxOgmoLoader(AssetPaths.Nivel2__oel);
		else if (Reg.numlvl == 3)
			ogmoLoader = new FlxOgmoLoader(AssetPaths.Nivel3__oel);

		tileMap = ogmoLoader.loadTilemap(AssetPaths.levelOneTiles__png, 20, 20, "tilesets");
		ogmoLoader.loadEntities(entityCreator, "entidades");
		FlxG.worldBounds.set(0, 0, tileMap.width, tileMap.height);
		for (i in 0...17){
			if (i == 0 || i == 6 || i == 7 || i == 8 || i == 9 || i == 15 || i == 16 || i == 17){
				tileMap.setTileProperties(i, FlxObject.NONE);
			}
			else{
				tileMap.setTileProperties(i, FlxObject.ANY);
			}
		}
		for (i in 0...Reg.PuertasLimitadoras.length){
			if (Reg.numlvl == 1){
				Reg.PuertasLimitadoras.members[i].SetEnemigosAAsesinar(Reg.enemigosNivel1[i]);
			}
			else if (Reg.numlvl == 2){
				Reg.PuertasLimitadoras.members[i].SetEnemigosAAsesinar(Reg.enemigosNivel2[i]);
			}
			else if (Reg.numlvl == 3){
				Reg.PuertasLimitadoras.members[i].SetEnemigosAAsesinar(Reg.enemigosNivel3[i]);
			}
		}
		add(fondoNoche);
		add(tileMap);
		musica.play();
		add(instanciando);
		add(Reg.Monedas);
		add(Reg.Caramelos);
		add(Reg.Helados);
		add(Reg.Botiquines);
		add(Reg.Pinches);
		add(puntajetext);
		add(vida);
		add(lives);
		add(Reg.Players);
		camera.follow(Reg.Players.members[0]);
		add(Reg.Enemigos);
		add(Reg.PlataformasFlotantes);
		add(Reg.Trampolines);
		add(Reg.PisosLetales);
		add(Reg.PisosLetalesGrandes);
		add(Reg.PuertasLimitadoras);
		Reg.enemigosMuertos = 0;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// HUD
		lives.text = ("LIVES: " + Reg.Players.members[0].GetLife());
		puntajetext.text = ("SCORE: " + Reg.score);
		vida.text = ("HEALTH: " + Reg.Players.members[0].GetVida());
		// HUD
		FlxG.collide(Reg.Players.members[0], tileMap);
		for (a in 0...Reg.Enemigos.length){
			Reg.Enemigos.members[a].GetGuia().HayPiso(tileMap);
		}
		for (a in 0...Reg.Enemigos.length){
			for (b in 0...Reg.Enemigos.length){
				if (b != a){
					if (Reg.Enemigos.members[a].GetdetectorDeEnemigos().overlaps(Reg.Enemigos.members[b]) && Reg.Enemigos.members[b].alive){
						Reg.Enemigos.members[a].GetdetectorDeEnemigos().SetNoEnemigos(false);
						Reg.Enemigos.members[a].SetearVelocidadACero();
					}
					else{
						Reg.Enemigos.members[a].GetdetectorDeEnemigos().SetNoEnemigos(true);
					}
				}
			}
		}
		for (a in 0...Reg.PuertasLimitadoras.length){
			FlxG.collide(Reg.PuertasLimitadoras.members[a], Reg.Enemigos);
		}
		//Colision entre Mili y el tilemap
		for (v in 0...Reg.Pinches.length){
			if (FlxG.overlap(Reg.Players.members[0], Reg.Pinches.members[v])){
				Reg.Players.members[0].ColisiondeSP();
				if (!(Reg.Players.members[0].Muerte())){
					Reg.Pinches.members[v].SonidoPisada();
				}
			}
			for (o in 0...Reg.Enemigos.length){
				if (FlxG.overlap(Reg.Enemigos.members[o], Reg.Pinches.members[v])){
					Reg.Enemigos.members[o].SetVida(0);
				}
			}
		}
		// Overlap del jugador con los objetos recolectables
		for (i in 0...Reg.Monedas.length){
			if (FlxG.overlap(Reg.Players.members[0], Reg.Monedas.members[i])){
				Reg.Monedas.members[i].Juntado();
			}
		}
		for (b in 0...Reg.Caramelos.length){
			Reg.Caramelos.members[b].Curado(Reg.Players.members[0]);
		}
		for (b in 0...Reg.Helados.length){
			Reg.Helados.members[b].Curado(Reg.Players.members[0]);
		}
		for (b in 0...Reg.Botiquines.length){
			Reg.Botiquines.members[b].Curado(Reg.Players.members[0]);
		}
		//Colision entre Mili y los trampolines
		for (i in 0...(Reg.Trampolines.members.length)){
			if ((Reg.Players.members[0].y + (Reg.Players.members[0].height / 2)) < Reg.Trampolines.members[i].y){
				if (FlxG.overlap(Reg.Players.members[0], Reg.Trampolines.members[i])){
					Reg.Trampolines.members[i].Aplastandolo(Reg.Players.members[0]);
					Reg.Players.members[0].SaltoTrampolin();
				}
		}
		//Colision entre Mili y las plataformas flotantes
		for (i in 0...(Reg.PlataformasFlotantes.members.length)){
			FlxG.collide(Reg.Players.members[0], Reg.PlataformasFlotantes.members[i]);
		}
		//colision entre Mili y el piso letal (Y enemigos y piso letal)
		for (i in 0...(Reg.PisosLetales.length)){
			if(FlxG.collide(Reg.Players.members[0], Reg.PisosLetales.members[i])){
				Reg.Players.members[0].instaKill();
			}
			for (o in 0...Reg.Enemigos.length){
				if (FlxG.overlap(Reg.Enemigos.members[o], Reg.PisosLetales.members[i])){
					Reg.Enemigos.members[o].SetVida(0);
				}
			}
		}
		for (i in 0...(Reg.PisosLetalesGrandes.length)){
			if(FlxG.collide(Reg.Players.members[0], Reg.PisosLetalesGrandes.members[i])){
				Reg.Players.members[0].instaKill();
			}
			for (o in 0...Reg.Enemigos.length){
				if (FlxG.overlap(Reg.Enemigos.members[o], Reg.PisosLetalesGrandes.members[i])){
					Reg.Enemigos.members[o].SetVida(0);
				}
			}
		}
		for (i in 0...(Reg.Checkpoints.length)){
			if (FlxG.overlap(Reg.Players.members[0], Reg.Checkpoints.members[i])){
				Reg.checkpointX = Reg.Checkpoints.members[i].GetX();
				Reg.checkpointY = Reg.Checkpoints.members[i].GetY();
				if (cpActivo >= 0)
					Reg.Checkpoints.members[cpActivo].SetActivo(false);
				cpActivo = i;
				Reg.Checkpoints.members[i].SetActivo(true);
				Reg.Checkpoints.members[i].SetPasado(true);
			}
		}
		Reg.Players.members[0].Salto();
		for (q in 0...Reg.PuertasLimitadoras.length){
			if (FlxG.collide(Reg.Players.members[0], Reg.PuertasLimitadoras.members[q])){
				Reg.PuertasLimitadoras.members[q].CheckeodePuertas();
			}
		}
		// colisiones de los enemigos
		for (i in 0...Reg.Enemigos.length){
			Reg.Players.members[0].GetGolpear().ColisionDelGolpe(Reg.Enemigos.members[i], Reg.Players.members[0]);
			Reg.Players.members[0].Agarrar(Reg.Enemigos.members[i]);
			Reg.Enemigos.members[i].DolorDelEnemigo(Reg.Players.members[0]);
			Reg.Enemigos.members[i].GetGolpeEnemigo().ColisionDelGolpeEnemigo(Reg.Players.members[0]);
		}
		for (i in 0...(Reg.Enemigos.members.length)){
			Reg.Enemigos.members[i].EnElAire();
			FlxG.collide(Reg.Enemigos.members[i], tileMap);
			if (Reg.Enemigos.members[i].isTouching(FlxObject.ANY)){
				Reg.Enemigos.members[i].SetSaltito(false);
			}
			else{
				Reg.Enemigos.members[i].SetSaltito(true);
			}
		}
		Reg.Players.members[0].Victoria(Reg.PuntoDeVictoria.members[0]);
		if (Reg.vidasJugador == 1 && Reg.saludJugador == 0){
			musica.stop();
		}
		if (Reg.victoria == true){
			musica.stop();
			if (Reg.numlvl == 1 || Reg.numlvl == 2)
			{
			Reg.numlvl++;
			Reg.victoria = false;
			FlxG.resetState();
			}
			else if (Reg.numlvl == 3)
			{
				Reg.victoria = false;
				FlxG.switchState(new CreditsState());
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
		for (p in 0...Reg.Monedas.length){
			instanciando.CrearDrops(Reg.Monedas.members[p]);
		}
		for (b in 0...Reg.Caramelos.length){
			instanciando.CrearDropsVida(Reg.Caramelos.members[b]);
		}
		for (b in 0...Reg.Helados.length){
			instanciando.CrearDropsVidaHelado(Reg.Helados.members[b]);
		}
		for (b in 0...Reg.Botiquines.length){
			instanciando.CrearDropsVidaBotiquin(Reg.Botiquines.members[b]);
		}
		for (q in 0...Reg.Pinches.length){
			instanciando.CrearSueloPeligroso(Reg.Pinches.members[q]);
		}
		for (k in 0...Reg.PisosLetales.length){
			instanciando.CrearPisoLetal(Reg.PisosLetales.members[k]);
		}
		for (k in 0...Reg.PisosLetalesGrandes.length){
			instanciando.CrearPisoLetalGrande(Reg.PisosLetalesGrandes.members[k]);
		}
		for (c in 0...Reg.Checkpoints.length){
			instanciando.CrearCheckPoint(Reg.Checkpoints.members[c]);
		}
		for (b in 0...Reg.PuertasLimitadoras.length){
			instanciando.CrearPuerta(Reg.PuertasLimitadoras.members[b]);
		}
		for (y in 0...Reg.PuntoDeVictoria.length){
			instanciando.CrearPuntoDeVictoria(Reg.PuntoDeVictoria.members[y]);
		}
	}
}
	private function entityCreator(entityName:String, entityData:Xml):Void{
		var entityStartX:Float = Std.parseInt(entityData.get("x"));
		var entityStartY:Float = Std.parseInt(entityData.get("y"));
		//	Me fijo que tipo de entidad tengo que inicializar...
		switch(entityName){
			case "enemigo":
				Reg.Enemigos.add(new Enemigo1(entityStartX, entityStartY));
			case "enemigosaltador":
				Reg.Enemigos.add(new EnemigoSaltador(entityStartX, entityStartY));
			case "enemigoconbate":
				Reg.Enemigos.add(new EnemigoConBate(entityStartX, entityStartY));
			case "plataformaflotante":
				Reg.PlataformasFlotantes.add(new PlataformaFlotante(entityStartX, entityStartY));
			case "trampolin":
				Reg.Trampolines.add(new Trampolin(entityStartX, entityStartY));
			case "jugador":
				Reg.Players.add(new Jugador(entityStartX, entityStartY, Reg.sofiElegida));
			case "pinches":
				Reg.Pinches.add(new SueloPeligroso(entityStartX, entityStartY));
			case "monedas":
				Reg.Monedas.add(new Drops(entityStartX, entityStartY));
			case "caramelos":
				Reg.Caramelos.add(new DropsVida(entityStartX, entityStartY));
			case "helados":
				Reg.Helados.add(new DropsVidaHelado(entityStartX, entityStartY));
			case "botiquines":
				Reg.Botiquines.add(new DropsVidaBotiquin(entityStartX, entityStartY));
			case "pisoletalgrande":
				Reg.PisosLetalesGrandes.add(new PisoLetalGrande(entityStartX, entityStartY));
			case "pisoletal":
				Reg.PisosLetales.add(new PisoLetal(entityStartX, entityStartY));
			case "checkpoint":
				Reg.Checkpoints.add(new CheckPoint(entityStartX, entityStartY));
			case "Puertas":
				Reg.PuertasLimitadoras.add(new Puertas(entityStartX, entityStartY));
			case "victoria":
				Reg.PuntoDeVictoria.add(new VictoryPoint(entityStartX, entityStartY));
		}
	}
}