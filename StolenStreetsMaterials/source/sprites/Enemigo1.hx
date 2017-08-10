package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;

/**
 * ...
 * @author MicaelaPereyra(Inicial)
 */
class Enemigo1 extends BaseEnemigo 
{
	private var still:Bool;
	private var combo:Bool;
	private var golpesVarios:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.ThyEnemigo__png, true, 50, 70);
		animation.add("Normal", [0, 0], 2, true);
		animation.add("Caminar", [5, 6, 7, 8, 9], 4, true);
		animation.add("Caer", [15], 2, true);
		animation.add("Pegar", [1], 7, false);
		animation.add("Ouch", [14], 7, false);
		animation.add("Saltar", [10, 10, 10], 4, false);
		animation.add("CaidaLibre", [12, 12], 2, true);
		animation.play("Normal");
		vidaEnemiga = Reg.vidaEnemiga;
		still = false;
		combo = false;
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		timer = 0;
		comboTimer = 0;
		golpesVarios = 0;
		isHurt = source.EstadoEnemigo.Normal;
		saltito = false;
		//trace("x " + x);
		//trace("y " + y);
		// offset.set(hitboxPosX, hitboxPosY); //traslada el hitbox //AFECTA A LA POSICION DE LOS GOLPES
	}
	// movimiento de este enemigo
	override public function move(){
		super.move();
		//trace(saltito + '0');
		if (isHurt == source.EstadoEnemigo.Normal && saltito == false){ // mientras no esta lastimado y no esta en el aire va poder moverse
			//trace(saltito + '1');
		if (!still){
			timer = 0;
			if (x < enemyRightMin && x < (enemyRightMax)){
				velocity.x = Reg.velocidadEnemiga;
				direccion = false;
				punioEnemigo.PosicionarGE();
				if (saltito == false){
					animation.play("Caminar");
				}
				flipX = true;
			}
			if (x > enemyLeftMin && x > (enemyLeftMax)){
				velocity.x = -(Reg.velocidadEnemiga);
				direccion = true;
				punioEnemigo.PosicionarGE();
				if (saltito == false){
					animation.play("Caminar");
				}
				flipX = false;
			}
		}
		if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - Reg.widthJugador * 2))
			|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + Reg.widthJugador * 2))){
				velocity.x = 0;
			if (timer <= Reg.effectTimer){
				golpesVarios++;
				animation.play("Pegar");
				still = true;
				if (golpesVarios > Reg.golpeFuerteMax){
					punioEnemigo.SetGolpeFuerte(true);
					punioEnemigo.PunietazoEnemigo(this, direccion);
				}
				else{
					punioEnemigo.PunietazoEnemigo(this, direccion);
				}
				
				if (golpesVarios > Reg.golpeCombo){
					combo = true;
					//trace("c-c-c-combo breaker!");
					punioEnemigo.PunietazoEnemigo(this, direccion);
					if (comboTimer > Reg.comboTimer){
						//trace("c-c-c-combo breaker!");
						if (comboTimer > Reg.comboTimerMax){
							punioEnemigo.PosicionarGE();
							punioEnemigo.PunietazoEnemigo(this, direccion);
							golpesVarios = 0;
							combo = false;
							comboTimer = 0;
						}
					}
					comboTimer++;
					
				}
				else{ 
					punioEnemigo.PunietazoEnemigo(this, direccion);
				}
			}
			else{
				if (timer > Reg.maxEffectTimer){
					timer = 0;
				}
				if (!combo){
					punioEnemigo.PosicionarGE();
				}
				punioEnemigo.SetGolpeFuerte(false);
			}
			timer++;
			if (animation.finished){
				animation.play("Normal");
			}
		}
		else
			still = false;
		}
		else{
			timer = 0;
			comboTimer = 0;
		}
	}
	override public function DolorDelEnemigo(agresor:Jugador){
		super.DolorDelEnemigo(agresor);
		/*if (isHurt == source.EstadoEnemigo.Lastimado){
			animation.play("Ouch");
		}
		else if (isHurt == source.EstadoEnemigo.Lanzado && saltito == true){
			animation.play("Caer");
		}*/
		if (animation.finished){
			isHurt = source.EstadoEnemigo.Normal;
		}
	}
	override public function EnElAire(){
		super.EnElAire();
		/*if (isTouching(FlxObject.ANY)){
			saltito = false;
		}
		else{
			saltito = true;
		}*/ // este pedazo de condon pinchado no lo lee aca pero si en playstate, joputa
		if (y > Reg.posYjugador + 30 && isHurt == source.EstadoEnemigo.Normal){
			if (saltito == false && velocity.y != Reg.jumpSpeed){
				velocity.y = Reg.jumpSpeed;
			}
		}
		if (saltito == true){
			animation.play("CaidaLibre");
		}
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (!Morir()){
			move();
			EnElAire();
		}
	}
}