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
 * @author RodrigoDiazKlipphan
 */
class Jugador extends FlxSprite{
	private var punios:Golpejugador; // los golpes
	private var direccion:Bool; // donde mira el personaje
	private var check:Bool; // chequea si el puñetazo esta presente (probablemente no sirva cuando haya animaciones)
	private var jump:Bool; // chequea si el personaje esta en el aire/saltando
	private var time:Int; // timer para efectos (principalmente para cuando el golpe esta en pantalla)
	private var thyHits:Int; // cantidad de golpes que se hacen durante un cierto lapso de tiempo (Combo)
	private var ComboActivation:Bool; // se utiliza para ver si la consecucion de golpes esta activada (Combo)
	private var meHurt:UInt; // se utiliza para saber si el personaje fue lastimado
	private var vidaActual:Int = Reg.VidaMili; //Hace que la vida actual sea igual que la base
	private var life:Int = Reg.VidaTotales; //Cuantas veces se puede reiniciar la barra si cae en 0
	/*(Comentar en playstate y descomentar aca)*/
	private var ay:Int; //descomentar si querer testear vida de jugador;
	private var auch:Int; // descomentar si querer testear vida de jugador
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
		meHurt = 0; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
		/*(Comentar en playstate y descomentar aca)*/
		// ay = 25;
		// auch = 10;
	}
	// todos los aspectos del movimiento del personaje
	public function MovimientoDelJugador():Void{
		// chequea si el personaje esta en el aire/saltando
		/*if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}*/
		// movimiento del personaje (derecha e izquierda)
		if (FlxG.keys.pressed.D && check==false && meHurt==0|| FlxG.keys.pressed.RIGHT && check==false && meHurt==0){
			velocity.x += Reg.hSpeed;
			facing = FlxObject.RIGHT;
			direccion = false;
		}
	    if (FlxG.keys.pressed.A && check==false && meHurt==0|| FlxG.keys.pressed.LEFT && check==false && meHurt==0){
			velocity.x -= Reg.hSpeed;
			facing = FlxObject.LEFT;
			direccion = true;
		}
		// Salto
		/*if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR) && check == false && meHurt==0 || FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR) && check == false && meHurt==0)
			velocity.y = Reg.jumpSpeed;
		if (velocity.x >= Reg.maxhSpeed)
			velocity.x = Reg.maxhSpeed;
		if (velocity.x <= -Reg.maxhSpeed)
			velocity.x = -Reg.maxhSpeed;*/
	}
	// el Salto 
	public function Salto(){
		// para saltar
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR) && check == false && meHurt==0 || FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR) && check == false && meHurt==0)
			velocity.y = Reg.jumpSpeed;
		if (velocity.x >= Reg.maxhSpeed)
			velocity.x = Reg.maxhSpeed;
		if (velocity.x <= -Reg.maxhSpeed)
			velocity.x = -Reg.maxhSpeed;
		// chequea si el personaje esta en el aire/saltando
		if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}
	}
	// getter del golpe
	public function GetGolpear(){
		return punios;
	}
	// el personaje golpea
	public function Golpear():Void{
		if (FlxG.keys.justPressed.J && check == false && meHurt==0){ // aparicion del puño
			check = true;
			if (jump == false){ // si no saltas, puedes hacer un Combo
				ComboActivation = true;
			}
			time = 0; // reinicia el timer
		}
		if (check == true){ // el puñetazo esta presente
			punios.PunietazoJugador(this, direccion, jump); // colocacion del puñetazo
			if (jump == false){ // el personaje se detiene al pegar
				velocity.x = 0;
				velocity.y = 0;
			}
			else{ // pero si esta saltando no ignora el movimiento del Salto
				if (FlxG.keys.pressed.D){ // chequea si te mueves a la derecha
					velocity.x += Reg.hSpeed;
				}
				else if (FlxG.keys.pressed.A){ // o a la izquierda
					velocity.x -= Reg.hSpeed;
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
		if (time > Reg.effectTimer || jump == true){ // si saltas, no
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
		if (pobreVictima.GetHurt() != 2){ // si la victima no esta lastimada
			if (overlaps(pobreVictima) && (pobreVictima.GetDireccion() != direccion)){ // Si el jugador colisiona con el enemigo en su misma direccion
				pobreVictima.SetHurt(1); // evita que se mueva
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
			}
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
		MovimientoDelJugador();
		Golpear();
		Combo();
		DolorDelJugador();
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
		if (jump == true){
			trace('midair');
		}
	}
}