package sprites;
import flixel.animation.FlxAnimation;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.Golpejugador;
import flixel.system.FlxSound;
import states.MenuState;
/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
class Jugador extends FlxSprite{
	private var punios:Golpejugador; // los golpes
	private var testTrampolin:Trampolin;
	private var direccion:Bool; // donde mira el personaje. true es derecha, false es izquierda.
	private var check:Bool; // chequea si el puÃ±etazo esta presente (probablemente no sirva cuando haya animaciones)
	private var jump:Bool; // chequea si el personaje esta en el aire/saltando
	private var agarrando:Bool; // este es un booleano para chequear el agarre
	private var time:Int; // timer para efectos (principalmente para cuando el golpe esta en pantalla)
	private var theHits:Int; // cantidad de golpes que se hacen durante un cierto lapso de tiempo (Combo)
	private var ComboActivation:Bool; // se utiliza para ver si la consecucion de golpes esta activada (Combo)
	private var miliOsofi:Bool; // se usa para saber si la personaje elegida es Mili o Sofia
	private var meHurt:EstadoEnemigo; // se utiliza para saber si el personaje fue lastimado
	private var vidaActual:Int = Reg.VidaMili; //Hace que la vida actual sea igual que la base
	private var life:Int = Reg.VidaTotales; //Cuantas veces se puede reiniciar la barra si cae en 0
	private var ay:Int; //descomentar si querer testear vida de jugador;
	private var auch:Int; // descomentar si querer testear vida de jugador
	private var esquivando:Bool = false; //indica si el jugador esta ejecutando su esquivada
	private var contadorEsquivar:Int = 0; //Cuenta la cantidad de frames en los que el personaje esta esquivando
	private var corriendo:Bool = false;
	private var velocidadCorrer:Int = 350;
	private var contadorPiniaCorriendo:Int = 0;
	private var piniaCorriendoTiempoMax:Int = 30;
	private var piniaCorriendo:Bool = false;
	private var anchuraObjeto:Int = 30;
	private var alturaObjeto:Int = 30;
	private var hitboxPosX = 20;
	private var hitboxPosY = 0;
	private var victoriosa:Bool;
	private var vencida:Bool;
	private var contadorpinches:Int = 0;
	private static inline var unSegundo:Int = 1;
	private var golpeAlAire:FlxSound;
	private var sonidoRespawn:FlxSound;
	private var sonidoSalto:FlxSound;
	private var sonidoSaltoTrampolin:FlxSound;
	private var sonidoMuerte:FlxSound;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, ?usaASofi:Bool){
		super(/*2563.7222222222*/X, /*2618*/Y, SimpleGraphic);
		trace("ZonaDeIncio");
		trace(X);
		trace(Y);
		miliOsofi = usaASofi;
		if (usaASofi == false){
			loadGraphic(AssetPaths.MiliFinal__png, true, 73, 82);
		}
		else{
			loadGraphic(AssetPaths.SofiSpriteSheet__png, true, 73, 82);
		}
		width = anchuraObjeto;								//AFECTA A LA POSICION DE LOS GOLPES
		offset.set(hitboxPosX, hitboxPosY); //traslada el hitbox //AFECTA A LA POSICION DE LOS GOLPES
		if (usaASofi == false){
			//Mili
			animation.add("Natural", [0, 10], 2, true);
			animation.add("Caminar", [0, 5, 6, 7, 8, 9], 6, true);
			animation.add("Victoria", [27, 28, 27, 28, 27, 28, 28, 28], 5, false);
		}
		else{
			//Sofi
			animation.add("Natural", [6], 2, true);
			animation.add("Caminar", [5, 6, 7, 8, 9, 10], 7, true);
			animation.add("Victoria", [27, 27, 27, 27, 27, 27], 5, false);
		}
		animation.add("Saltar", [1, 2, 2, 3], 5, false);
		animation.add("Aterrizaje", [4], 6, false);
		animation.add("CaidaLibre", [3], 2, true);
		animation.add("Golpe", [17, 18, 19], 7, false);
		animation.add("SegundoGolpe", [20, 21, 22], 7, false);
		animation.add("Patada", [24], 2, true);
		animation.add("Correr", [11, 12, 13, 14, 15, 16], 7, true);
		animation.add("Danio", [23, 23, 23], 1, false);
		animation.add("Caida", [25], 1, true);
		animation.add("Muerte", [26, 26, 26, 26], 1, false);
		animation.add("EnElSuelo", [26, 26], 2, false);
		if (usaASofi == false){
			// Mili
			animation.add("Agarre", [29, 29, 29], 5, false);
			animation.add("Agarrando", [29], 2, true);
		}
		else{
			// Sofi
			animation.add("Agarre", [28, 28, 28], 5, false);
			animation.add("Agarrando", [28], 2, true);
		}
		animation.play("Natural");
		// animation.play("Caminar");
		acceleration.y = Reg.gravedad; // gravedad
		// makeGraphic(30, 30, FlxColor.PINK);
		drag.x = Reg.jugadorDrag; // delimito la velocidad
		punios = new Golpejugador(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		direccion = false;
		check = false;
		time = 0;
		theHits = 0;
		ComboActivation = false;
		jump = false;
		agarrando = false; // sin uso
		victoriosa = false;
		vencida = false;
		meHurt = source.EstadoEnemigo.Normal; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
		golpeAlAire = new FlxSound();
		golpeAlAire.loadEmbedded(AssetPaths.airslap__wav);
		golpeAlAire.volume = 1;
		//sonidos
		sonidoRespawn = new FlxSound();
		sonidoRespawn.loadEmbedded(AssetPaths.respawn__wav);
		sonidoRespawn.volume = 1;
		sonidoSalto = new FlxSound();
		sonidoSalto.loadEmbedded(AssetPaths.jump__wav);
		sonidoSalto.volume = 1;
		sonidoSaltoTrampolin = new FlxSound();
		sonidoSaltoTrampolin.loadEmbedded(AssetPaths.trampolin__wav);
		sonidoSaltoTrampolin.volume = 1;
		sonidoMuerte = new FlxSound();
		sonidoMuerte.loadEmbedded(AssetPaths.muerte__wav);
		sonidoMuerte.volume = 1;
	}
	// todos los aspectos del movimiento del personaje
	public function MovimientoDelJugador():Void{
		if (check == false && meHurt == source.EstadoEnemigo.Normal && esquivando == false && agarrando == false){
			if (FlxG.keys.pressed.RIGHT){
				if(corriendo == false){
					velocity.x = Reg.hSpeed;
					if ((!FlxG.keys.pressed.UP && !FlxG.keys.pressed.S) && jump == false){
						animation.play("Caminar");
					}
				}
				else{
					velocity.x = velocidadCorrer;
					if (((!FlxG.keys.pressed.UP && !FlxG.keys.pressed.S) && jump == false)){
					animation.play("Correr");
					}
				}
			facing = FlxObject.RIGHT;
			direccion = false;
			setFacingFlip(FlxObject.RIGHT, direccion, false);
		}
	    if (FlxG.keys.pressed.LEFT){
				if(corriendo == false){
					velocity.x = -Reg.hSpeed;
					if (((!FlxG.keys.pressed.UP && !FlxG.keys.pressed.S) && jump == false)){
						animation.play("Caminar");
					}
				}
				else{
					velocity.x = -velocidadCorrer;
					if ((!FlxG.keys.pressed.UP && !FlxG.keys.pressed.S) && jump == false){
						animation.play("Correr");
					}
				}
				facing = FlxObject.LEFT;
				direccion = true;
				setFacingFlip(FlxObject.LEFT, direccion, false);
			}
			if ((FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.LEFT) && (jump == false)){
				animation.play("Natural");
			}
		}
	}
	// el Salto 
	public function Salto(){
		// para saltar
		if (vencida == false){
		if 
		(
		 FlxG.keys.justPressed.UP &&(isTouching(FlxObject.FLOOR) || isTouching(FlxObject.ANY)) && check == false && meHurt == source.EstadoEnemigo.Normal || 
		 FlxG.keys.justPressed.S && (isTouching(FlxObject.FLOOR) || isTouching(FlxObject.ANY)) && check == false && meHurt == source.EstadoEnemigo.Normal ){
			velocity.y = Reg.jumpSpeed;
			animation.play("Saltar");
			sonidoSalto.play();
		}
		// chequea si el personaje esta en el aire/saltando
		if (isTouching(FlxObject.FLOOR) && victoriosa == false || isTouching(FlxObject.ANY) && victoriosa == false){
			if (jump == true)
				animation.play("Aterrizaje");
			jump = false;
		}
		else{
			jump = true;
			if(animation.finished){
				animation.play("CaidaLibre");
			}
		}
		}
	}
	// comportamiento que adopta el personaje cuando colisiona con un trampolin
	public function SaltoTrampolin(){
		if (meHurt == source.EstadoEnemigo.Normal && !(Muerte())){
			velocity.y = Reg.velocidadDelTrampolin; 
			animation.stop();
			animation.play("CaidaLibre");
			sonidoSaltoTrampolin.play();
		}
	}
	// comportamiento que adopta el personaje cuando colisiona con el pinche
	public function ColisiondeSP(){
		if (contadorpinches == unSegundo)
		{
			if (vidaActual > 0)
				vidaActual -= 1;
		contadorpinches = 0;
		}
		contadorpinches++;
	}
	// getter del golpe
	public function GetGolpear(){
		return punios;
	}
	// el personaje golpea
	public function Golpear():Void{
		if (FlxG.keys.justPressed.D && check == false && meHurt == source.EstadoEnemigo.Normal){ // aparicion del puÃ±o
			check = true;
			if (jump == false){ // Animaciones de ataque del jugador
				if (theHits < Reg.comboFuerteJugador - 1){
					animation.play("Golpe");
					golpeAlAire.play();
				}
				else if (theHits == Reg.comboFuerteJugador - 1){
					animation.play("SegundoGolpe");
					golpeAlAire.play();
				}
				else{
					animation.play("Golpe");
				}
			}
			else if (jump == true){
				animation.play("Patada");
				golpeAlAire.play();
			}
			if (corriendo == true){	
				if (direccion == true){
					velocity.x = Reg.hSpeed;
					piniaCorriendo = true;
				}
				else if (direccion == false){
					velocity.x = -Reg.hSpeed;
					piniaCorriendo = true;
				}
			}
			else if(jump == false){
				ComboActivation = true;
			}
			time = 0; // reinicia el timer
		}
		if (check == true){ // el punietazo esta presente
			punios.PunietazoJugador(this, direccion, jump, piniaCorriendo, miliOsofi); // colocacion del puÃ±etazo
			if (jump == false){ // el personaje se detiene al pegar
				velocity.x = 0;
				velocity.y = 0;
			}
			else{ // pero si esta saltando no ignora el movimiento del Salto
				if (FlxG.keys.pressed.RIGHT){ // chequea si te mueves a la derecha
					velocity.x = Reg.hSpeed;
				}
				else if (FlxG.keys.pressed.LEFT){ // o a la izquierda
					velocity.x = -Reg.hSpeed;
				}
			}
			if (check == true && ComboActivation == false && jump == false){ // si tocas el piso si atacas saltando, el ataque desaparece
				punios.posicionar();
				check = false;
			}
		}
		if (ComboActivation == true){ // timer para finalizar el Combo
			time++;
		}
		if (animation.finished && jump == false){
			punios.posicionar();
			check = false;
			animation.play("Natural");
		}
	}
	// contador de golpes consecutivos (Combo)
	public function Combo():Void{
		if (FlxG.keys.justPressed.D && jump == false && meHurt == source.EstadoEnemigo.Normal){ // si no saltas, puedes hacer Combos en tierra
			theHits++;
		}
		if (time > Reg.effectTimer || jump == true){ // si saltas, no, y lo agarras no se seteara a 0 hasta que se suelte
			theHits = 0;
			time = 0;
			ComboActivation = false;
		}
		if (theHits > Reg.comboFuerteJugador){ // si haces mas de tres golpes, el Combo se reinicia
			theHits = 0;
		}
	}
	// dolor despues del golpe
	public function DolorDelJugador(){
		if (meHurt == source.EstadoEnemigo.Lastimado && vidaActual > 0){
			time++;
			if (jump == false){
				animation.play("Danio");
			}
			else{
				animation.play("Caida");
			}
			if (time > Reg.effectTimer && jump == false){
				time = 0;
				meHurt = source.EstadoEnemigo.Normal;
				animation.play("Natural");
			}
		}
	}
	// agarre
	public function Agarrar(pobreVictima:BaseEnemigo){
		if (pobreVictima.GetHurt() != source.EstadoEnemigo.Lanzado){ // Si el enemigo no esta volando
			if (FlxG.keys.justPressed.E && check == false && meHurt == source.EstadoEnemigo.Normal){ // y apretas Z (Para probar, despues cambiamos la letra)
				if (jump == false){ // in progress
					animation.play("Agarre");
					punios.SetAgarrada(true);
					punios.PunietazoJugador(this, direccion, jump, piniaCorriendo, miliOsofi);
				}
			}
			if (punios.GetAgarrada() == true && pobreVictima.GetHurt() == source.EstadoEnemigo.Agarrado){ // ahora, si lo tenes agarrado podes hacer las siguientes cosas
				if (FlxG.keys.justPressed.D){ // si la sostenes de un lado y apretas Atacar y avanzar
					punios.SetAgarrada(false);
					pobreVictima.SetHurt(source.EstadoEnemigo.Lanzado); // vuela en esa direccion
					pobreVictima.SetTimer(0); // y reinicia el timer
				}
			}
		}
		if (punios.GetAgarrada() == true){
			velocity.x = 0;
			velocity.y = 0;
		}
		agarrando = punios.GetAgarrada();
	}
	public function instaKill(){
		vidaActual = 0;
	}
	public function Muerte(){
		if (vidaActual <= 0){
			if (vencida == false){
				vencida = true;
				sonidoMuerte.play();
				}
			if (animation.getByName("Muerte").paused){
					animation.play("Muerte");
			}
			if (animation.getByName("Muerte").finished){
				if (life != 0){
					vidaActual = Reg.VidaMili;
					x = Reg.checkpointX;
					y = Reg.checkpointY;
					life--;
					sonidoRespawn.play();
				}
				if (life == 0){
					FlxG.switchState(new MenuState());
					kill();
				}
			}
			return true;
		}
		vencida = false;
		return false;
	}
	public function Victoria(punto:VictoryPoint){
		if (overlaps(punto) && victoriosa == false){
			victoriosa = true;
			animation.stop();
			animation.play("Victoria");
		}
		if (victoriosa == true && animation.getByName("Victoria").finished){
			Reg.victoria = victoriosa;
		}
	}
	// setter y getter del bool de direccion (para donde esta mirando el personaje)
	public function GetDireccion(){
		return direccion;
	}
	public function SetDireccion(esto:Bool){
		direccion = esto;
	}
	// setter y getter del Combo (golpes consecutivos)
	public function GetCombo(){
		return theHits;
	}
	public function SetCombo(ComboMaster:Int){
		theHits = ComboMaster;
	}
	// retorna si el personaje esta saltando
	public function GetJump(){
		return jump;
	}
	// retorna si el personaje esta corriendo
	public function GetCorriendo(){
		return corriendo;
	}
	// setter y getter de si el personaje esta lastimado
	public function SetMeHurt(duele:EstadoEnemigo){
		meHurt = duele;
	}
	public function GetMeHurt(){
		return meHurt;
	}
	// setter y getter del timer basico del jugador
	public function SetTime(tiempo:Int){
		time = tiempo;
	}
	public function GetTime(){
		return time;
	}
	// setter y getter de la vida actual del jugador
	public function SetVida(vida:Int){
		vidaActual = vida;
	}
	public function GetVida(){
		return vidaActual;
	}
	// setter y getter de los reintentos
	public function SetLife(oportunidades:Int){
		life = oportunidades;
	}
	public function GetLife(){
		return life;
	}
	// setter y getter del check
	public function SetCheck(comprobador:Bool){
		check = comprobador;
	}
	public function GetCheck(){
		return check;
	}
	// setter y getter del booleano de agarrar
	public function SetAgarrando(grab:Bool){
		agarrando = grab;
	}
	public function GetAgarrando(){
		return agarrando;
	}
	// setters y getters de la X y la Y
	public function SetXJugador(thyX:Float){
		x = thyX;
	}
	public function SetYJugador(thyY:Float){
		y = thyY;
	}
	public function GetXJugador():Float{
		return x;
	}
	public function GetYJugador():Float{
		return y;
	}
	public function SetVictoriosa(yay:Bool){
		victoriosa = yay;
	}
	public function GetVictoriosa():Bool{
		return victoriosa;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// camara
		Reg.posXjugador = x;
		Reg.posYjugador = y;
		Reg.widthJugador = width;
		Reg.heightJugador = height; //actualiza el reg con los datos del jugador
		Reg.direccionJugador = direccion;
		Reg.vidasJugador = life;
		Reg.saludJugador = vidaActual;
		// reformulacion con updates comentada (comentar en playstate estas acciones y descomentar aca)
		if (!Muerte() && victoriosa == false){
			if (piniaCorriendo == false){
				MovimientoDelJugador();
				Combo();
				DolorDelJugador();
			}
			Golpear();
			if (piniaCorriendo == true){
				punios.SetGolpeDuro(true);
				punios.PunietazoJugador(this, direccion, jump, piniaCorriendo, miliOsofi);
				contadorPiniaCorriendo++;
			}
			if (contadorPiniaCorriendo >= piniaCorriendoTiempoMax){
				piniaCorriendo = false;
				contadorPiniaCorriendo = 0;
				punios.posicionar();
			}
			// delimitacion de la habilidad de escape del personaje
			if (contadorEsquivar >= Reg.retardoEsquivar){
				esquivando = false;
				contadorEsquivar = 0;
			}
			else if (esquivando == true){
				contadorEsquivar++;
			}
			if (FlxG.keys.pressed.A || FlxG.keys.pressed.SHIFT)
				corriendo = true;
			else
				corriendo = false;
		}
		Muerte();
		/*trace("datos");
		trace(CPX);
		trace(CPY);
		trace("donde estoy");
		trace(x);
		trace(y);
		trace("donde realmente estoy");
		trace(Reg.posXjugador);
		trace(Reg.posYjugador);*/
		//trace((FlxG.camera.scroll.x + 5) + " " + x);
	}
}