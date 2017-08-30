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
 * @author RodrigoDiazKlipphan
 */
class EnemigoSaltador extends BaseEnemigo{
	private var still:Bool;
	private var combo:Bool;
	private var golpesVarios:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.EnemigoSaltador__png, true, 50, 70);
		animation.add("Normal", [0, 1, 2, 3], 4, true);
		animation.add("Caminar", [5, 6, 7, 8, 9, 10, 11], 7, true);
		animation.add("Lanzado", [15, 16, 17, 18], 6, false);
		animation.add("Pegar", [12, 13], 6, false);
		animation.add("Ouch", [20, 21], 4, false);
		animation.add("Grah", [22, 23], 4, false);
		animation.add("Saltar", [14, 14, 14], 4, false);
		animation.add("Caido", [24, 25, 26], 4, false);
		animation.add("CaidaLibre", [14], 2, true);
		animation.add("Muerte", [27, 28, 29, 29, 29], 2, false);
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
	}
	// movimiento de este enemigo
	override public function move(){
		//trace(saltito + '0');
		if (isHurt == source.EstadoEnemigo.Normal && saltito == false && vidaEnemiga > 0){
			if (x < enemyRightMin && x < (enemyRightMax)){
				direccion = false;
				if (saltito == false){
					punioEnemigo.PosicionarGE();
				}
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
			if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - Reg.widthJugador * 2) && isHurt == source.EstadoEnemigo.Normal)
				|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + Reg.widthJugador * 2)) && isHurt == source.EstadoEnemigo.Normal){
				isHurt = source.EstadoEnemigo.Saltando;
			}
		}
		if (isHurt == source.EstadoEnemigo.Lastimado || isHurt == source.EstadoEnemigo.Agarrado){
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
		if (isHurt == source.EstadoEnemigo.Saltando){
			if (animation.getByName("Saltar").paused){
				animation.play("Saltar");
				velocity.y = Reg.velocidadDeVueloY;
				if (direccion == false){
					velocity.x = Reg.velocidadDeVueloX;
				}
				else if (direccion == true){
					velocity.x = Reg.velocidadDeVueloX * ( -1);
				}
			}
			if (animation.getByName("Saltar").finished){
				if (saltito == false){
					animation.play("CaidaLibre");
				}
				if (saltito == true){
					animation.play("Normal");
					animation.play("Pegar");
					punioEnemigo.PunietazoEnemigo(this, direccion);
					isHurt = source.EstadoEnemigo.Normal;
					trace("enter");
				}
			}
			else{
				velocity.y = Reg.velocidadDeVueloY;
			}
		}
		else if (saltito == true && animation.getByName("Saltar").finished && isHurt == source.EstadoEnemigo.Normal){
			punioEnemigo.PunietazoEnemigo(this, direccion);
		}
		else{
			punioEnemigo.PosicionarGE();
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
			//EnElAire();
			Sequito();
		}
		else{
			isHurt = source.EstadoEnemigo.Muerto;
			Morir();
			velocity.x = 0;
		}
	}
}