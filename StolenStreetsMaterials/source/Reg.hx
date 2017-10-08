package source;

import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.CheckPoint;
import sprites.DropsVida;
import sprites.DropsVidaHelado;
import sprites.DropsVidaBotiquin;
import sprites.Jugador;
import sprites.Golpejugador;
import sprites.Enemigo1;
import sprites.Obstaculo;
import sprites.PlataformaFlotante;
import sprites.BaseEnemigo;
import sprites.Puertas;
import sprites.Trampolin;
import sprites.SueloPeligroso;
import sprites.Drops;
import sprites.PisoLetal;
import sprites.PisoLetalGrande;
import sprites.CheckPoint;
import sprites.Puertas;
import sprites.VictoryPoint;


/**
 * ...
 * @author RodrigoDiazKlipphan(inicial)
 */
enum EstadoEnemigo{
	Normal;
	Lastimado;
	Lanzado;
	Agarrado;
	Saltando;
	EnElPiso;
	Muerto;
}
class Reg{
	public static var enemigosMuertos:Int = 0;
	
	public static inline var hSpeed:Float = 200; // velocidad horizontal estandar del jugador
	public static inline var maxhSpeed:Float = 200; // velocidad horizontal maxima del jugador
	public static inline var hSpeedEnemigo:Float = 100; // velocidad horizontal estandar del enemigo
	
	public static inline var EnemigoVelocidadVuelo:Float = 30; //velocidad a la que vuela el enemigo
	public static inline var vSpeed:Float = -220; // velocidad vertical estandar de enemigos y player, (no es gravedad)
	public static inline var friction:Float = 15; // friccion estandar
	public static inline var effectTimer:Float = 20; // maximo de un timer de comportamiento estandar (aunque por ahora estoy haciendo cualquier cosa)
	public static inline var comboTimer:Float = 10;
	public static inline var maxEffectTimer:Float = effectTimer * 5; // un timer de comportamiento por encima del estandar (por si algo dura sin efecto)
	public static inline var jumpSpeed:Float = -600; // velocidad estandar de un Salto
	public static inline var VidaMili:Int = 100; //Vida base de Mili
	public static inline var posicionDeLosPunios:Int = 0; // a donde se van las hitboxes cuando no aparecen
	public static inline var velocidadPlataformasFlotantes:Float = 50; // velocidad de las plataformas que flotan
	public static inline var golpeFuerteMax:Int = 100;
	public static inline var punietazoEnemigoDerecha:Int = 25;
	public static inline var punietazoEnemigoIzquierda:Int = -5;
	public static inline var punietazoEnemigoPosVertical:Int = 30;
	public static inline var punietazoJugadorDerecha:Int = 20;
	public static inline var punietazoJugadorIzquierda:Int = -15;
	public static inline var punietazoJugadorPosVertical:Int = 50;
	public static inline var patadaJugadorVertical:Int = 80;
	public static inline var danioPunioNormal:Int = -5;
	public static inline var danioPunioFuerte:Int = -10;
	public static inline var danioPunioJugadorNormal:Int = -10;
	public static inline var danioPunioJugadorTercero:Int = -15;
	public static inline var danioPunioJugadorFuerte:Int = -20;
	public static inline var velocidadDelTrampolin:Int = -750;
	public static inline var retardoEsquivar:Int = 30;
	public static inline var comboFuerteJugador:Int = 3;
	public static inline var punioEnPantalla:Int = 5;
	public static inline var gravedad:Int = 1500;
	public static inline var jugadorDrag:Int = 1000;
	public static inline var esquivada:Int = 25;
	public static inline var vidaEnemiga:Int = 50;
	public static inline var velocidadEnemiga:Int = 100;
	public static inline var elNumeroMagicoDeMica:Int = 8000;
	public static inline var velocidadDeVueloX:Float = 160;
	public static inline var velocidadDeVueloY:Float = -150;
	public static inline var enemigoPegaIzquierda:Float = -25;
	public static inline var enemigoPegaDerecha:Float = 10;
	
	static public var posYjugador:Float; //guarda la posicion del jugador
	static public var posXjugador:Float; //guarda la posicion del jugador
	static public var widthJugador:Float; //guarda el ancho del jugador
	static public var heightJugador:Float; //guardar el alto del jugador
	static public var direccionJugador:Bool;
	static public var rosaOgotica:Bool = false;
	static public var victoria:Bool = false;
	
	static public var checkpointX:Float;
	static public var checkpointY:Float;
	
	static public var puntaje:Int = 0; //guarda el puntaje
	static public var score:Float = 0; // guerda el dinero del personaje
	public static inline var VidaTotales:Int = 6; // vidas que tiene el jugador
	static public var numlvl:Int;
	static public var vidasJugador:Int;
	static public var saludJugador:Int;
	
	static public var enemigosNivel1 = [1, 3, 5, 8, 10, 11, 13, 16, 17, 20, 25]; // el ultimo numero ignorenlo, despues contamos bien
	static public var Enemigos:FlxTypedGroup<BaseEnemigo>;
	static public var PlataformasFlotantes:FlxTypedGroup<PlataformaFlotante>;
	static public var Trampolines:FlxTypedGroup<Trampolin>;
	static public var Players:FlxTypedGroup<Jugador>;
	static public var Cajitas:FlxTypedGroup<Obstaculo>;
	static public var Pinches:FlxTypedGroup<SueloPeligroso>;
	static public var Monedas:FlxTypedGroup<Drops>;
	static public var Caramelos:FlxTypedGroup<DropsVida>;
	static public var Helados:FlxTypedGroup<DropsVidaHelado>;
	static public var Botiquines:FlxTypedGroup<DropsVidaBotiquin>;
	static public var PisosLetales:FlxTypedGroup<PisoLetal>;
	static public var PisosLetalesGrandes:FlxTypedGroup<PisoLetalGrande>;
	static public var Checkpoints:FlxTypedGroup<CheckPoint>;
	static public var PuertasLimitadoras:FlxTypedGroup<Puertas>;
	static public var PuntoDeVictoria:FlxTypedGroup<VictoryPoint>;
}