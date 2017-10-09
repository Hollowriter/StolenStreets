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
		animation.add("Saltar", [14, 14, 14], 5, false);
		animation.add("Caido", [24, 25, 26], 4, false);
		animation.add("CaidaLibre", [14], 2, true);
		animation.add("Muerte", [27, 28, 29, 29, 29], 7, false);
		animation.play("Normal");
		vidaEnemiga = Reg.vidaEnemiga;
		still = false;
		combo = false;
		punioEnemigo = new GolpeEnemigo(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios);
		guia = new GuiaEnemigo(x, y);
		timer = 0;
		comboTimer = 0;
		golpesVarios = 0;
		estaLastimado = source.EstadoEnemigo.Normal;
		saltito = false;
		animacionEmpezo = false;
		muriendo = false;
		muerto = false;
	}
	// movimiento de este enemigo
	override public function move(){
		if (estaLastimado == source.EstadoEnemigo.Normal && saltito == false && vidaEnemiga > 0){
			if (x < enemyRightMin && x < (enemyRightMax)){
				direccion = false;
				if (saltito == false){
					punioEnemigo.PosicionarGE();
				}
				if (saltito == false){
					if (guia.GetMovete() == true && detectorDeEnemigos.GetNoEnemigos() == true){
						velocity.x = Reg.velocidadEnemiga;
						animation.play("Caminar");
					}
					else if (guia.GetMovete() == false || detectorDeEnemigos.GetNoEnemigos() == false){
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
					if (guia.GetMovete() == true && detectorDeEnemigos.GetNoEnemigos() == true){
						velocity.x = -(Reg.velocidadEnemiga);
						animation.play("Caminar");
					}
					else if (guia.GetMovete() == false || detectorDeEnemigos.GetNoEnemigos() == false){
						velocity.x = 0;
						animation.play("Normal");
					}
				}
				flipX = false;
			}
			if ((x < enemyRightMin - Reg.widthJugador && x > (enemyLeftMin - ((Reg.widthJugador * 2) + 200)) && (direccion != Reg.direccionJugador) && estaLastimado == source.EstadoEnemigo.Normal)
				|| (x > enemyLeftMin + Reg.widthJugador && x < (enemyRightMin + ((Reg.widthJugador * 2) + 200))) && (direccion != Reg.direccionJugador) && estaLastimado == source.EstadoEnemigo.Normal){
				estaLastimado = source.EstadoEnemigo.Saltando;
			}
		}
		if (estaLastimado == source.EstadoEnemigo.Lastimado || estaLastimado == source.EstadoEnemigo.Agarrado){
			punioEnemigo.PosicionarGE();
			velocity.x = 0;
		}
	}
	override public function DolorDelEnemigo(agresor:Jugador){
		super.DolorDelEnemigo(agresor);
		if (saltito == false){
			if (estaLastimado == source.EstadoEnemigo.Lastimado){
				if (animation.getByName("Ouch").paused){
					animation.play("Ouch");
				}
			}
			if (estaLastimado == source.EstadoEnemigo.Lanzado){
				if (animation.getByName("Lanzado").paused){
					animation.play("Lanzado");
					velocity.y = Reg.jumpSpeed;
				}
			}
		}
		if (estaLastimado == source.EstadoEnemigo.Lastimado){
			if (animation.getByName("Ouch").finished){
				estaLastimado = source.EstadoEnemigo.Normal;
			}
		}
		if (estaLastimado == source.EstadoEnemigo.Lanzado){
			if (!(animation.getByName("Lanzado").finished)){
				velocity.y = Reg.velocidadDeVueloY;
				if (direccion == false){
					velocity.x = Reg.velocidadDeVueloX * (-1);
				}
				else if (direccion == true){
					velocity.x = Reg.velocidadDeVueloX;
				}
			}
			if (saltito == false && animation.getByName("Lanzado").finished && estaLastimado == source.EstadoEnemigo.Lanzado){
				estaLastimado = source.EstadoEnemigo.EnElPiso;
				velocity.x = 0;
				animation.play("Caido");
			}
		}
		if (estaLastimado == source.EstadoEnemigo.EnElPiso && animation.getByName("Caido").finished){
			velocity.x = 0;
			velocity.y = 0;
			estaLastimado = source.EstadoEnemigo.Normal;
		}
	}
	override public function EnElAire(){
		if (estaLastimado == source.EstadoEnemigo.Saltando){
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
					estaLastimado = source.EstadoEnemigo.Normal;
				}
			}
			else{
				velocity.y = Reg.velocidadDeVueloY;
			}
		}
		else if (estaLastimado == source.EstadoEnemigo.Lanzado || estaLastimado == source.EstadoEnemigo.Lastimado){
			punioEnemigo.PosicionarGE();
		}
		else if (saltito == true && animation.getByName("Saltar").finished && estaLastimado == source.EstadoEnemigo.Normal){
			punioEnemigo.PunietazoEnemigo(this, direccion);
		}
		else{
			punioEnemigo.PosicionarGE();
		}
	}
	override public function Morir(){
		super.Morir();
		if (vidaEnemiga <= 0){
			velocity.x = 0;
			guia.MuerteEnemigo();
			detectorDeEnemigos.MuerteEnemigo();
			if (animacionEmpezo == false){
				animation.play("Muerte");
				animacionEmpezo = true;
			}
			if (animation.getByName("Muerte").finished && animacionEmpezo == true){
				muerto = true;
			}
		}
	}
	override public function SetearVelocidadACero(){
		super.SetearVelocidadACero();
		if (animation.getByName("Normal").paused){
			animation.play("Normal");
		}
	}
	public function Sequito():Void{
		if (estaLastimado == source.EstadoEnemigo.Normal){
			guia.Seguidor(x, y, flipX);
			detectorDeEnemigos.RadarDeEnemigos(x, y, flipX);
		}
		else{
			guia.Seguidor(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios, flipX);
			detectorDeEnemigos.RadarDeEnemigos(Reg.posicionDeLosPunios, Reg.posicionDeLosPunios, flipX);
		}
	}
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		if (vidaEnemiga > 0){
			move();
			Sequito();
		}
		else{
			estaLastimado = source.EstadoEnemigo.Muerto;
			Morir();
			velocity.x = 0;
		}
	}
}