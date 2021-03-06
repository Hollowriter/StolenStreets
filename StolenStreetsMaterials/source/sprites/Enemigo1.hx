package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import source.Reg;
import sprites.GolpeEnemigo;
import sprites.GuiaEnemigo;
import flixel.system.FlxSound;

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
		loadGraphic(AssetPaths.PrimerEnemigo__png, true, 50, 70);
		animation.add("Normal", [1, 2, 3, 4, 5], 4, true);
		animation.add("Caminar", [12, 13, 14, 15, 16, 17], 4, true);
		animation.add("Lanzado", [23, 28, 29, 30], 7, false);
		animation.add("Pegar", [6, 7], 6, false);
		animation.add("GolpeFuerte", [10, 11], 6, false);
		animation.add("Ouch", [22, 22, 22], 4, false);
		animation.add("Saltar", [20, 20, 20], 4, false);
		animation.add("Caido", [30, 31, 32], 4, false);
		animation.add("CaidaLibre", [20, 20], 2, true);
		animation.add("Agarrado", [28], 1, true);
		animation.add("Muerte", [23, 24, 25, 26, 27, 27, 27], 7, false);
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
		muerto = false;
		muriendo = false;
	}
	// movimiento de este enemigo
	override public function move(){
		if (estaLastimado == source.EstadoEnemigo.Normal && saltito == false && vidaEnemiga > 0){ // mientras no esta lastimado y no esta en el aire va poder moverse
		if (!still){
			timer = 0;
			if (x < enemyRightMin && x < (enemyRightMax)){
				direccion = false;
				punioEnemigo.PosicionarGE();
				if (saltito == false && estaLastimado != source.EstadoEnemigo.Agarrado){
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
		}
		if ((x < enemyRightMin - Reg.widthJugador && x > ((enemyLeftMin - Reg.widthJugador * 2) + Reg.enemigoPegaDerecha) 
			&& estaLastimado == source.EstadoEnemigo.Normal)
			|| (x > enemyLeftMin + Reg.widthJugador && x < ((enemyRightMin + Reg.widthJugador * 2) + Reg.enemigoPegaIzquierda)) 
			&& estaLastimado == source.EstadoEnemigo.Normal){
				velocity.x = 0;
			if (timer <= Reg.effectTimer){
				golpesVarios++;
				if (golpesVarios < Reg.golpeFuerteMax){
					animation.play("Pegar");
				}
				else{
					animation.play("GolpeFuerte");
				}
				still = true;
				if (estaLastimado == source.EstadoEnemigo.Normal){
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
			if (animation.finished && estaLastimado == source.EstadoEnemigo.Normal){
				animation.play("Normal");
			}
		}
		else
			still = false;
		}
		else if (estaLastimado == source.EstadoEnemigo.Lastimado || estaLastimado == source.EstadoEnemigo.Agarrado){
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
				if (animation.getByName("Ouch").finished){
					estaLastimado = source.EstadoEnemigo.Normal;
				}
			}
			if (estaLastimado == source.EstadoEnemigo.Lanzado){
				if (animation.getByName("Lanzado").paused){
					animation.play("Lanzado");
					velocity.y = Reg.jumpSpeed;
				}
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
		if (estaLastimado == source.EstadoEnemigo.EnElPiso && animation.getByName("Caido").finished && estaLastimado != source.EstadoEnemigo.Agarrado){
			velocity.x = 0;
			velocity.y = 0;
			estaLastimado = source.EstadoEnemigo.Normal;
		}
		if (estaLastimado == source.EstadoEnemigo.Agarrado){
			animation.play("Agarrado");
		}
	}
	override public function EnElAire(){
		super.EnElAire();
		if (saltito == true && estaLastimado == source.EstadoEnemigo.Normal){
			animation.play("CaidaLibre");
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
			EnElAire();
			Sequito();
		}
		else{
			estaLastimado = source.EstadoEnemigo.Muerto;
			Morir();
		}
	}
}