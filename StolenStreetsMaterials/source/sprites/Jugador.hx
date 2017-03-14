package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.Golpe;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Jugador extends FlxSprite{
	private var punios:Golpe; // los golpes
	private var direccion:Bool; // donde mira el personaje
	private var check:Bool; // chequea si el puñetazo esta presente (probablemente no sirva cuando haya animaciones)
	private var jump:Bool; // chequea si el personaje esta en el aire/saltando
	private var time:Int; // timer para efectos (principalmente para cuando el golpe esta en pantalla)
	private var thyHits:Int; // cantidad de golpes que se hacen durante un cierto lapso de tiempo (combo)
	private var comboActivation:Bool; // se utiliza para ver si la consecucion de golpes esta activada (combo)
	private var meHurt:UInt; // se utiliza para saber si el personaje fue lastimado
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		acceleration.y = 1500; // gravedad
		makeGraphic(30, 30, FlxColor.PINK);
		drag.x = 1000; // delimito la velocidad
		punios = new Golpe(1000, 1000);
		direccion = false;
		check = false;
		time = 0;
		thyHits = 0;
		comboActivation = false;
		jump = false;
		meHurt = 0; // Lo cambie de Bool a Uint para poder diferenciar entre no estar lastimado, estarlo y estar lastimado por un golpe fuerte
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		// camara
		if (x <= FlxG.camera.scroll.x + 5)
			x = FlxG.camera.scroll.x + 5;
		if (x + width >= FlxG.camera.scroll.x + FlxG.camera.width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y <= 5)
			y = 5;
		if (y + height >= FlxG.height)
			y = FlxG.height - height;
	}
	// todos los aspectos del movimiento del personaje
	public function playerMovement():Void{
		// chequea si el personaje esta en el aire/saltando
		if (isTouching(FlxObject.FLOOR)){
			jump = false;
		}
		else{
			jump = true;
		}
		// movimiento del personaje (derecha e izquierda)
		if (FlxG.keys.pressed.D && check==false && meHurt==0){
			velocity.x += Reg.hSpeed;
			facing = FlxObject.RIGHT;
			direccion = false;
		}
	    if (FlxG.keys.pressed.A && check==false && meHurt==0){
			velocity.x -= Reg.hSpeed;
			facing = FlxObject.LEFT;
			direccion = true;
		}
		// salto
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR) && check == false && meHurt==0)
			velocity.y = Reg.vSpeed;
		if (velocity.x >= Reg.maxhSpeed)
			velocity.x = Reg.maxhSpeed;
		if (velocity.x <= -Reg.maxhSpeed)
			velocity.x = -Reg.maxhSpeed;
	}
	// getter del golpe
	public function getGolpear(){
		return punios;
	}
	// el personaje golpea
	public function golpear():Void{
		if (FlxG.keys.justPressed.J && check == false && meHurt==0){ // aparicion del puño
			check = true;
			if (jump == false){ // si no saltas, puedes hacer un combo
				comboActivation = true;
			}
			time = 0; // reinicia el timer
		}
		if (check == true){ // el puñetazo esta presente
			punios.niapi(this, direccion, jump); // colocacion del puñetazo
			if (jump == false){ // el personaje se detiene al pegar
				velocity.x = 0;
				velocity.y = 0;
			}
			else{ // pero si esta saltando no ignora el movimiento del salto
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
		if (check == true && comboActivation == false && isTouching(FlxObject.FLOOR)){ // si tocas el piso si atacas saltando, el ataque desaparece
			punios.posicionar();
			check = false;
		}
		if (comboActivation == true){ // timer para finalizar el combo
			time++;
		}
	}
	// contador de golpes consecutivos (combo)
	public function combo():Void{
		if (FlxG.keys.justPressed.J && jump == false && meHurt==0){ // si no saltas, puedes hacer combos en tierra
			thyHits++;
		}
		if (time > Reg.effectTimer || jump == true){ // si saltas, no
			thyHits = 0;
			time = 0;
			comboActivation = false;
		}
		if (thyHits > 3){ // si haces mas de tres golpes, el combo se reinicia
			thyHits = 0;
		}
	}
	// dolor despues del golpe
	public function pain(){
		if (meHurt==1){
			time++;
			if (time > Reg.effectTimer){
				time = 0;
				meHurt = 0;
			}
		}
	}
	// setter y getter del bool de direccion (para donde esta mirando el personaje)
	public function getDireccion(){
		return direccion;
	}
	public function setDireccion(esto:Bool){
		direccion = esto;
	}
	// setter y getter del combo (golpes consecutivos)
	public function getCombo(){
		return thyHits;
	}
	public function setCombo(comboMaster:Int){
		thyHits = comboMaster;
	}
	// retorna si el personaje esta saltando
	public function getJump(){
		return jump;
	}
	// setter y getter de si el personaje esta lastimado
	public function setMeHurt(duele:UInt){
		meHurt = duele;
	}
	public function getMeHurt(){
		return meHurt;
	}
	// setter y getter del timer basico del jugador
	public function setTime(tiempo:Int){
		time = tiempo;
	}
	public function getTime(){
		return time;
	}
}