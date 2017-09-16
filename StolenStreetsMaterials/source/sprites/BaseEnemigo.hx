package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.ds.IntMap;
import sprites.GolpeEnemigo;
import flixel.FlxObject;
import flixel.FlxG;
import source.Reg;

/**
 * ...
 * @author MicaelaPereyra
 */
class BaseEnemigo extends FlxSprite 
{
	private var vidaEnemiga:Int; // vida del enemigo
	private var direccion:Bool; // para donde esta mirando
	private var isHurt:EstadoEnemigo; // chequea si recibio un golpe
	private var saltito:Bool; // chequea si esta en el aire
	private var punioEnemigo:GolpeEnemigo; // nuevo golpe del enemigo
	private var anchuraObjeto:Int = 30;
	private var alturaObjeto:Int = 30;
	private var guia:GuiaEnemigo;
	private var camarada:GuiaEnemigo;
	private var enemyRightMin:Float;
	private var timer:Int;
	private var comboTimer:Int;
	private var muerto:Bool;
	private var muriendo:Bool;
	public var enemyRightMax:Float;
	public var enemyLeftMin:Float;
	public var enemyLeftMax:Float;
	public var enemyUpper:Float;
	private var animacionEmpezo:Bool;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = Reg.gravedad;
		// offset.set(hitboxPosX, hitboxPosY); //traslada el hitbox //AFECTA A LA POSICION DE LOS GOLPES
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		guia = new GuiaEnemigo(x, y);
		camarada = new GuiaEnemigo(x, y);
		animacionEmpezo = false;
		muriendo = false;
	}
	public function move(){};
	public function gotHitted(){};
	public function EnElAire(){}
	public function DolorDelEnemigo(agresor:Jugador){
		if (isHurt == source.EstadoEnemigo.Lastimado){ // si esta lastimado normalmente
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
		} // esta cosa con timer hacia OP a mili
		else if (isHurt == source.EstadoEnemigo.Lanzado){ // si esta lastimado por un golpe duro
			punioEnemigo.PosicionarGE(); // elimina el ataque del enemigo
		}
	}
	public function Morir(){
		if (vidaEnemiga <= 0 && muriendo == false){
			Reg.enemigosMuertos++;
			muriendo = true;
		}
	}
	public function SetVida(health:Int){
		vidaEnemiga = health;
	}
	public function GetVida(){
		return vidaEnemiga;
	}
	// setter del dolor del enemigo
	public function SetHurt(hurted:EstadoEnemigo){
		isHurt = hurted;
	}
	// retorna si el enemigo esta lastimado
	public function GetHurt():EstadoEnemigo{
		return isHurt;
	}
	// setter y getter del timer de comportamiento
	public function SetTimer(forThyTimer:Int){
		timer = forThyTimer;
	}
	public function GetTimer(){
		return timer;
	}
	// setter y getter de la direccion del enemigo
	public function SetDireccion(mirando:Bool){
		mirando = direccion;
	}
	public function GetDireccion(){
		return direccion;
	}
	public function GetGolpeEnemigo():GolpeEnemigo{
		return punioEnemigo;
	}
	public function SetSaltito(salto:Bool){
		saltito = salto;
	}
	public function GetSaltito():Bool{
		return saltito;
	}
	public function GetGuia():GuiaEnemigo{
		return guia;
	}
	public function GetCamarada():GuiaEnemigo{
		return camarada;
	}
	public function SetMuerto(moribundo:Bool){
		muerto = moribundo;
	}
	public function GetMuerto():Bool{
		return muerto;
	}
	public function SetearVelocidadACero(){
		velocity.x = 0;
	}
	public function SetX(seinX:Float){
		x = seinX;
	}
	public function SetY(seinY:Float){
		y = seinY;
	}
	public function GetX():Float{
		return x;
	}
	public function GetY():Float{
		return y;
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (muerto == false){
			enemyRightMin = Reg.posXjugador;
			enemyRightMax = Reg.posXjugador - (Reg.widthJugador * 2);
			enemyLeftMin = Reg.posXjugador;
			enemyLeftMax = Reg.posXjugador + (Reg.widthJugador * 2);
			enemyUpper = Reg.posYjugador;
		}
	}
}