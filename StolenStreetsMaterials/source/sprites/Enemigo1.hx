package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;
import sprites.GuiaEnemigo;

/**
 * ...
 * @author MicaelaPereyra(Inicial)
 */
class Enemigo1 extends BaseEnemigo 
{
	private var still:Bool;
	private var combo:Bool;
	private var animacionEmpezo:Bool;
	private var golpesVarios:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PrimerEnemigo__png, true, 50, 70);
		animation.add("Normal", [1, 2, 3, 4, 5], 4, true);
		animation.add("Caminar", [12, 13, 14, 15, 16, 17], 4, true);
		animation.add("Lanzado", [23, 28, 29, 30], 6, false);
		animation.add("Pegar", [6, 7], 6, false);
		animation.add("GolpeFuerte", [10, 11], 6, false);
		animation.add("Ouch", [22, 22, 22], 4, false);
		animation.add("Saltar", [20, 20, 20], 4, false);
		animation.add("Caido", [30, 31, 32], 4, false);
		animation.add("CaidaLibre", [20, 20], 2, true);
		animation.add("Muerte", [23, 24, 25, 26, 27, 27, 27], 3, false);
		animation.play("Normal");
		vidaEnemiga = Reg.vidaEnemiga;
		still = false;
		combo = false;
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		guia = new GuiaEnemigo(x, y);
		timer = 0;
		comboTimer = 0;
		golpesVarios = 0;
		isHurt = source.EstadoEnemigo.Normal;
		saltito = false;
		animacionEmpezo = false;
		muerto = false;
		//trace("x " + x);
		//trace("y " + y);
		// offset.set(hitboxPosX, hitboxPosY); //traslada el hitbox //AFECTA A LA POSICION DE LOS GOLPES
	}
	// movimiento de este enemigo
	override public function move(){
		//trace(saltito + '0');
		if (isHurt == source.EstadoEnemigo.Normal && saltito == false && vidaEnemiga > 0){ // mientras no esta lastimado y no esta en el aire va poder moverse
			//trace(saltito + '1');
		if (!still){
			timer = 0;
			if (x < enemyRightMin && x < (enemyRightMax)){
				direccion = false;
				punioEnemigo.PosicionarGE();
				if (saltito == false){
					if (guia.GetColision() == true){
						velocity.x = Reg.velocidadEnemiga;
						animation.play("Caminar");
					}
					else if (guia.GetColision() == false){
						velocity.x = 0;
						animation.play("Normal");
					}
				}
				flipX = true;
			}
			if (x > enemyLeftMin && x > (enemyLeftMax)){
				direccion = true;
				punioEnemigo.PosicionarGE();
				if (saltito == false){
					if (guia.GetColision() == true){
						velocity.x = -(Reg.velocidadEnemiga);
						animation.play("Caminar");
					}
					else if (guia.GetColision() == false){
						velocity.x = 0;
						animation.play("Normal");
					}
				}
				flipX = false;
			}
		}
		if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - Reg.widthJugador * 2) && isHurt == source.EstadoEnemigo.Normal)
			|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + Reg.widthJugador * 2)) && isHurt == source.EstadoEnemigo.Normal){
				velocity.x = 0;
				trace("golpeando");
			if (timer <= Reg.effectTimer){
				golpesVarios++;
				if (golpesVarios < Reg.golpeFuerteMax){
					animation.play("Pegar");
				}
				else{
					animation.play("GolpeFuerte");
				}
				still = true;
				if (golpesVarios > Reg.golpeFuerteMax && isHurt == source.EstadoEnemigo.Normal){
					punioEnemigo.SetGolpeFuerte(true);
					punioEnemigo.PunietazoEnemigo(this, direccion);
				}
				else if (isHurt == source.EstadoEnemigo.Normal){
					punioEnemigo.PunietazoEnemigo(this, direccion);
				}
				if (golpesVarios > Reg.golpeCombo && isHurt == source.EstadoEnemigo.Normal){
					combo = true;
					punioEnemigo.PunietazoEnemigo(this, direccion);
					if (comboTimer > Reg.comboTimer){
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
			if (animation.finished && isHurt == source.EstadoEnemigo.Normal){
				animation.play("Normal");
			}
		}
		else
			still = false;
		}
		else if (isHurt == source.EstadoEnemigo.Lastimado || isHurt == source.EstadoEnemigo.Agarrado){
			punioEnemigo.PosicionarGE();
			velocity.x = 0;
		}
	}
	override public function DolorDelEnemigo(agresor:Jugador){
		super.DolorDelEnemigo(agresor);
		if (saltito == false){
			if (isHurt == source.EstadoEnemigo.Lastimado){
				if (animation.getByName("Ouch").paused){
					animation.play("Ouch");
				}
			}
			if (isHurt == source.EstadoEnemigo.Lanzado){
				if (animation.getByName("Lanzado").paused){
					animation.play("Lanzado");
					velocity.y = Reg.jumpSpeed;
				}
			}
		}
		if (isHurt == source.EstadoEnemigo.Lastimado){
			if (animation.getByName("Ouch").finished){
				isHurt = source.EstadoEnemigo.Normal;
			}
		}
		if (isHurt == source.EstadoEnemigo.Lanzado){
			if (!(animation.getByName("Lanzado").finished)){
				velocity.y = Reg.velocidadDeVueloY;
				if (direccion == false){
					velocity.x = Reg.velocidadDeVueloX * (-1);
				}
				else if (direccion == true){
					velocity.x = Reg.velocidadDeVueloX;
				}
			}
			if (saltito == false && animation.getByName("Lanzado").finished && isHurt == source.EstadoEnemigo.Lanzado){
				isHurt = source.EstadoEnemigo.EnElPiso;
				animation.play("Caido");
			}
		}
		if (isHurt == source.EstadoEnemigo.EnElPiso && animation.getByName("Caido").finished){
			velocity.x = 0;
			velocity.y = 0;
			isHurt = source.EstadoEnemigo.Normal;
		}
	}
	override public function EnElAire(){
		super.EnElAire();
		/*if (y > Reg.posYjugador + 30 && isHurt == source.EstadoEnemigo.Normal){
			if (saltito == false && velocity.y != Reg.jumpSpeed){
				velocity.y = Reg.jumpSpeed;
			}
		}*/
		if (saltito == true && isHurt == source.EstadoEnemigo.Normal){
			animation.play("CaidaLibre");
		}
	}
	override public function Morir():Void{
		if (vidaEnemiga <= 0){
			if (animacionEmpezo == false){
				animation.play("Muerte");
				animacionEmpezo = true;
			}
			if (animation.getByName("Muerte").finished && animacionEmpezo == true){
				muerto = true;
			}
		}
	}
	public function Sequito():Void{
		guia.Seguidor(x, y, flipX);
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (vidaEnemiga > 0){
			move();
			EnElAire();
			Sequito();
		}
		else{
			isHurt = source.EstadoEnemigo.Muerto;
			Morir();
		}
	}
}