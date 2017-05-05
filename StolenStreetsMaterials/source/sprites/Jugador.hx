package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.Golpejugador;

/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
class Jugador extends FlxSprite{
	private var punios:Golpejugador; // los golpes
	

	
	private var testTrampolin:Trampolin;
	private var direccion:Bool; // donde mira el personaje. true es derecha, false es izquierda.
	private var check:Bool; // chequea si el puñetazo esta presente (probablemente no sirva cuando haya animaciones)
	private var jump:Bool; // chequea si el personaje esta en el aire/saltando
	private var agarrando:Bool; // este es un booleano para chequear el agarre
	private var time:Int; // timer para efectos (principalmente para cuando el golpe esta en pantalla)
	private var thyHits:Int; // cantidad de golpes que se hacen durante un cierto lapso de tiempo (Combo)
	private var ComboActivation:Bool; // se utiliza para ver si la consecucion de golpes esta activada (Combo)
	private var meHurt:UInt; // se utiliza para saber si el personaje fue lastimado
	private var vidaActual:Int = Reg.VidaMili; //Hace que la vida actual sea igual que la base
	private var life:Int = Reg.VidaTotales; //Cuantas veces se puede reiniciar la barra si cae en 0
	private var ay:Int; //descomentar si querer testear vida de jugador;
	private var auch:Int; // descomentar si querer testear vida de jugador
	private var esquivando:Bool = false; //indica si el jugador esta ejecutando su esquivada
	private var contadorEsquivar:Int = 0; //Cuenta la cantidad de frames en los que el personaje esta esquivando
	private var corriendo:Bool = false;
	private var velocidadCorrer:Int = 350;
	
	private var controlesWASD:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500; // gravedad
		makeGraphic(30, 30, FlxColor.PINK);
		drag.x = 1000; // delimito la velocidad
		punios = new Golpejugador(1000, 1000);
		direccion = false;
		check = false;
		time = 0;
		thyHits = 0;
		ComboActivation = false;
		jump = false;
		agarrando = false;
		meHurt = 0; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
		/*(Anteriormente eran usados para probar la vida, ahora estan sin utilizar)*/
		// ay = 25;
		// auch = 10;
	}
	// todos los aspectos del movimiento del personaje
	public function MovimientoDelJugador():Void{
		// chequea si el personaje esta en el aire/saltando (Pasado a la funcion Salto())
		/*if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}*/
		// movimiento del personaje (derecha e izquierda) (Reformule un poquito para emprolijar)
		if (agarrando == false && check == false && meHurt == 0 && esquivando == false){
			if (FlxG.keys.pressed.D && controlesWASD == true /*&& check == false && meHurt == 0 && esquivando == false*/ || 
			FlxG.keys.pressed.RIGHT && controlesWASD == false /*&& check == false && meHurt == 0 && esquivando == false*/){
				if(corriendo == false)
					velocity.x = Reg.hSpeed;
				else
					velocity.x = velocidadCorrer;
			facing = FlxObject.RIGHT;
			direccion = false;
		}
	    if (FlxG.keys.pressed.A && controlesWASD == true /* && check==false && meHurt==0 && esquivando == false*/ || 
		FlxG.keys.pressed.LEFT && controlesWASD == false /*&& check==false && meHurt==0 && esquivando == false*/){
				if(corriendo == false)
					velocity.x = -Reg.hSpeed;
				else
					velocity.x = -velocidadCorrer;
				facing = FlxObject.LEFT;
				direccion = true;
			}
		}
	}
	//Movimiento de escape del personaje
	private function Esquivar(){
		if ((((((FlxG.keys.justPressed.I) && jump == false)) && esquivando == false && controlesWASD == true)  || (FlxG.keys.justPressed.W) && jump == false  && controlesWASD == false)){
			if(direccion)
				x += 25;
			else
				x -= 25;
			velocity.x = 0;
			esquivando = true;
		}
	}
	// el Salto 
	public function Salto(){
		// para saltar
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR) && check == false && meHurt == 0 && esquivando == false && agarrando == false && controlesWASD == true || 
		FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR) && check == false && meHurt == 0 && esquivando == false && agarrando == false && controlesWASD == false||
		FlxG.keys.justPressed.K && isTouching(FlxObject.FLOOR) && check == false && meHurt == 0 && esquivando == false && agarrando == false && controlesWASD == true|| 
		FlxG.keys.justPressed.S && isTouching(FlxObject.FLOOR) && check == false && meHurt==0 && esquivando == false && agarrando == false && controlesWASD == false)
			velocity.y = Reg.jumpSpeed;
		/*if (velocity.x >= Reg.maxhSpeed)
			velocity.x = Reg.maxhSpeed;
		if (velocity.x <= -Reg.maxhSpeed)
			velocity.x = -Reg.maxhSpeed; */
		// chequea si el personaje esta en el aire/saltando
		if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}
	}
	// comportamiento que adopta el personaje cuando colisiona con un trampolin
	public function SaltoTrampolin(){
		velocity.y = -750;
	}
	// getter del golpe
	public function GetGolpear(){
		return punios;
	}
	// el personaje golpea
	public function Golpear():Void{
		if ((FlxG.keys.justPressed.J && check == false && meHurt==0 && controlesWASD == true) || FlxG.keys.justPressed.D && check == false && meHurt==0 && controlesWASD == false){ // aparicion del puño
			check = true;
			if (jump == false){ // si no saltas, puedes hacer un Combo
				ComboActivation = true;
			}
			time = 0; // reinicia el timer
		}
		if (check == true){ // el puñetazo esta presente
			punios.PunietazoJugador(this, direccion, jump); // colocacion del puñetazo
			if (agarrando == true){ // esto para evitar que le pege eternamente
				check = false;
			}
			if (jump == false){ // el personaje se detiene al pegar
				velocity.x = 0;
				velocity.y = 0;
			}
			else{ // pero si esta saltando no ignora el movimiento del Salto
				if ((FlxG.keys.pressed.D && controlesWASD == true) || (FlxG.keys.pressed.RIGHT && controlesWASD == false)){ // chequea si te mueves a la derecha
					velocity.x = Reg.hSpeed;
				}
				else if (FlxG.keys.pressed.A && controlesWASD == true || FlxG.keys.pressed.LEFT && controlesWASD == false){ // o a la izquierda
					velocity.x = -Reg.hSpeed;
				}
			}
		}
		if (time > 5){ // en este tiempo, el puñetazo desaparece
			punios.posicionar();
			check = false;
		}
		if (check == true && ComboActivation == false && jump == false){ // si tocas el piso si atacas saltando, el ataque desaparece
			punios.posicionar();
			check = false;
		}
		if (ComboActivation == true){ // timer para finalizar el Combo
			time++;
		}
	}
	// contador de golpes consecutivos (Combo)
	public function Combo():Void{
		if (FlxG.keys.justPressed.J && jump == false && meHurt==0){ // si no saltas, puedes hacer Combos en tierra
			thyHits++;
		}
		if (time > Reg.effectTimer && agarrando == false || jump == true){ // si saltas, no, y lo agarras no se seteara a 0 hasta que se suelte
			thyHits = 0;
			time = 0;
			ComboActivation = false;
		}
		if (thyHits > 3){ // si haces mas de tres golpes, el Combo se reinicia
			thyHits = 0;
		}
	}
	// dolor despues del golpe
	public function DolorDelJugador(){
		if (meHurt==1){
			time++;
			if (time > Reg.effectTimer){
				time = 0;
				meHurt = 0;
			}
		}
	}
	// agarre
	public function Agarrar(pobreVictima:Enemigo){
		/*if (pobreVictima.GetHurt() != 2){ // si la victima no esta lastimada
			if (overlaps(pobreVictima) && (pobreVictima.GetDireccion() != direccion) && thyHits <= 3){ // Si el jugador colisiona con el enemigo en su misma direccion
				pobreVictima.SetHurt(1); // evita que se mueva
				agarrando = true; // evita que el timer del combo avance
				pobreVictima.velocity.x = 0; // lo detiene
				velocity.x = 0; // y el jugador se detiene sin poder avanzar a la direccion donde esta agarrando al enemigo
				if (FlxG.keys.pressed.D && FlxG.keys.justPressed.J && direccion == false){ // si la sostenes de un lado y apretas Atacar y avanzar
					pobreVictima.SetHurt(2); // vuela en esa direccion
					pobreVictima.SetTimer(0); // y reinicia el timer
				}
				if(FlxG.keys.pressed.A && FlxG.keys.justPressed.J && direccion == true){ // o si la sostenes del otro
					pobreVictima.SetHurt(2); // vuela en esa direccion
					pobreVictima.SetTimer(0); // y reinicia el timer
				}
				if (thyHits > 2){ // esto por si lo cagas a rodillazos
					pobreVictima.SetHurt(2);
					pobreVictima.SetTimer(0);
				}
			}
			else{
				agarrando = false; // se cancela
				// trace("checked"); (para revisar si entraba a esta parte del if)
			}*/ // antiguo agarre
		if (pobreVictima.GetHurt() != 2){ // Si el enemigo no esta volando
			/*Antes de que sigan leyendo, estoy pensando en cambiar una condicion. 
			La razon es para que el agarre sea mas util y mas logico, que puedas agarrar al enemigo tanto por delante como por detras.*/
			if (overlaps(pobreVictima) && /*esta->*//*(pobreVictima.GetDireccion() != direccion)*//*<-esta*/ thyHits <= 3){ // Si estas muy cerca del enemigo
				if ((FlxG.keys.justPressed.U && check == false && meHurt==0 && controlesWASD == true) || (FlxG.keys.justPressed.E && check == false && meHurt==0 && controlesWASD == false)){ // y apretas Z (Para probar, despues cambiamos la letra)
					// pobreVictima.SetHurt(1); // tomas al enemigo
					agarrando = true; // agarrandolo
					pobreVictima.velocity.x = 0; // deteniendolo
					velocity.x = 0; // y el personaje se queda firme
				}
				if (agarrando == true){ // ahora, si lo tenes agarrado podes hacer las siguientes cosas
					if ((FlxG.keys.pressed.D && FlxG.keys.justPressed.J && direccion == false && controlesWASD == true) || (FlxG.keys.pressed.RIGHT && FlxG.keys.justPressed.D && direccion == false && controlesWASD == false)){ // si la sostenes de un lado y apretas Atacar y avanzar
						agarrando = false; // para salir volando esto tiene que quedar en false
						pobreVictima.SetHurt(2); // vuela en esa direccion
						pobreVictima.SetTimer(0); // y reinicia el timer
					}
					if ((FlxG.keys.pressed.A && FlxG.keys.justPressed.J && direccion == true) || (FlxG.keys.pressed.RIGHT && FlxG.keys.justPressed.D && direccion == true && controlesWASD == false)){ // o si la sostenes del otro
						agarrando = false; // para salir volando esto tiene que setearse a false
						pobreVictima.SetHurt(2); // vuela en esa direccion
						pobreVictima.SetTimer(0); // y reinicia el timer
					}
					if (thyHits > 2){ // esto por si terminas el combo de los rodillazos
						agarrando = false; // para salir volando esto tiene que quedar en false
						pobreVictima.SetHurt(2); // vuela a la derecha o a la izquierda, dependiendo de donde lo agarres
						pobreVictima.SetTimer(0); // y reinicia el timer
					} // El tiempo que dura el agarre esta determinado por el timer del enemigo (Mirar el dummy)
				}
			}
		} // aca termina el nuevo agarre
	} // y termina la funcion
	// setter y getter del bool de direccion (para donde esta mirando el personaje)
	public function GetDireccion(){
		return direccion;
	}
	public function SetDireccion(esto:Bool){
		direccion = esto;
	}
	// setter y getter del Combo (golpes consecutivos)
	public function GetCombo(){
		return thyHits;
	}
	public function SetCombo(ComboMaster:Int){
		thyHits = ComboMaster;
	}
	// retorna si el personaje esta saltando
	public function GetJump(){
		return jump;
	}
	// setter y getter de si el personaje esta lastimado
	public function SetMeHurt(duele:UInt){
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
	// setter y getter del booleano de agarrar
	public function SetAgarrando(grab:Bool){
		agarrando = grab;
	}
	public function GetAgarrando(){
		return agarrando;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// camara
		Reg.posXjugador = x;
		Reg.posYjugador = y;
		Reg.widthJugador = width;
		Reg.heightJugador = height; //actualiza el reg con los datos del jugador
		if (x <= FlxG.camera.scroll.x + 5)
			x = FlxG.camera.scroll.x + 5;
		if (x + width >= FlxG.camera.scroll.x + FlxG.camera.width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y <= 5)
			y = 5;
		if (y + height >= FlxG.height)
			y = FlxG.height - height;
		//¿Cuanta vida tiene?
		if (vidaActual <= 0 && life != 0)
		{
			vidaActual = Reg.VidaMili;
			life -= 1;
			trace("Reinicio de vida");
		}
		if (vidaActual <= 0 && life == 0){
			trace("No hay mas vida");
			kill();
		}
		// reformulacion con updates comentada (comentar en playstate estas acciones y descomentar aca)
		if (FlxG.keys.pressed.L && controlesWASD == true || FlxG.keys.pressed.A && controlesWASD == false)
			corriendo = true;
			MovimientoDelJugador();
		Golpear();
		Combo();
		DolorDelJugador();
		Esquivar();
		// testeos de vida
		/*if (FlxG.keys.justPressed.L){
			life = GetVida();
			life -= auch;
			SetVida(life);
		}
		if (FlxG.keys.justPressed.K){
			life = GetVida();
			life -= ay;
			SetVida(life);
		}*/
		// testeo para ver si el personaje esta en el aire
		/*if (jump == true){
			trace('midair');
		}*/
		// delimitacion de la habilidad de escape del personaje
		if (contadorEsquivar >= 30){
			esquivando = false;
			contadorEsquivar = 0;
		}
		else if (esquivando == true){
			contadorEsquivar++;
		}
		if((FlxG.keys.pressed.T) == false)
			corriendo = false;
	}
}