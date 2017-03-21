package source;

import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.Golpe;

/**
 * ...
 * @author AfanadosDeOtroProyecto+UnPoquitoDeRodrigoDiazKlipphan
 */
class Reg{
	public static inline var hSpeed:Float = 30; // velocidad horizontal estandar
	public static inline var maxhSpeed:Float = 200; // velocidad horizontal maxima
	public static inline var vSpeed:Float = -220; // velocidad vertical estandar
	public static inline var friction:Float = 15; // friccion estandar
	public static inline var effectTimer:Float = 20; // maximo de un timer de comportamiento estandar (aunque por ahora estoy haciendo cualquier cosa)
	public static inline var jumpSpeed:Float = -600; // velocidad estandar de un salto
	public static inline var VidaMili:Int = 100; //Vida base de Mili
	static public var posYjugador:Float; //guarda la posicion del jugador
	static public var posXjugador:Float; //guarda la posicion del jugador
	static public var widthJugador:Float; //guarda el ancho del jugador
	static public var heightJugador:Float; //guardar el alto del jugador
}