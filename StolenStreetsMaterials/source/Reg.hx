package source;

import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.Golpejugador;
import sprites.Enemigo;
import sprites.PlataformaFlotante;

/**
 * ...
 * @author AfanadosDeOtroProyecto+UnPoquitoDeRodrigoDiazKlipphan(inicial)
 */
class Reg{
	public static inline var hSpeed:Float = 200; // velocidad horizontal estandar del jugador
	public static inline var hSpeedEnemigo:Float = 100; // velocidad horizontal estandar del enemigo
	public static inline var EnemigoVelocidadVuelo:Float = 30; //velocidad a la que vuela el enemigo
	public static inline var maxhSpeed:Float = 200; // velocidad horizontal maxima
	public static inline var vSpeed:Float = -220; // velocidad vertical estandar
	public static inline var friction:Float = 15; // friccion estandar
	public static inline var effectTimer:Float = 20; // maximo de un timer de comportamiento estandar (aunque por ahora estoy haciendo cualquier cosa)
	public static inline var comboTimer:Float = 10;
	public static inline var comboTimerMax:Float = comboTimer * 2;
	public static inline var maxEffectTimer:Float = effectTimer * 5; // un timer de comportamiento por encima del estandar (por si algo dura sin efecto)
	public static inline var jumpSpeed:Float = -600; // velocidad estandar de un Salto
	public static inline var VidaMili:Int = 100; //Vida base de Mili
	public static inline var posicionDeLosPunios:Int = 1000; // a donde se van las hitboxes cuando no aparecen
	public static inline var velocidadPlataformasFlotantes:Float = 50; // velocidad de las plataformas que flotan
	public static inline var golpeFuerteMax:Int = 100;
	public static inline var golpeCombo:Int = 200;
	
	static public var posYjugador:Float; //guarda la posicion del jugador
	static public var posXjugador:Float; //guarda la posicion del jugador
	static public var widthJugador:Float; //guarda el ancho del jugador
	static public var heightJugador:Float; //guardar el alto del jugador
	
	
	static public var puntaje:Int = 0; //guarda el puntaje
	static public var guita:Float = 0; // guerda el dinero del personaje
	public static inline var VidaTotales:Int = 3; // vidas que tiene el jugador
	
	static public var Enemigos:FlxTypedGroup<Enemigo>;
	static public var PlataformasFlotantes:FlxTypedGroup<PlataformaFlotante>;
	
}