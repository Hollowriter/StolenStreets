package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author RodrigoDiazKlipphan
 */
class Instanciador extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
	}
	public function CrearEnemigo(enemigo:BaseEnemigo){
		if (!(enemigo.Morir())){
			if (!(enemigo.isOnScreen())){
				enemigo.kill();
			}
			else{
				enemigo.revive();
			}
		}
		else{
			enemigo.kill();
		}
	}
	public function CrearObstaculo(obstaculo:Obstaculo){
		if (!(obstaculo.GetRoto())){
			if (!(obstaculo.isOnScreen())){
				obstaculo.kill();
			}
			else{
				obstaculo.revive();
			}
		}
		else{
			obstaculo.kill();
		}
	}
	public function CrearPlataformaFlotante(plataformaFlotante:PlataformaFlotante){
		if (!(plataformaFlotante.isOnScreen())){
			plataformaFlotante.kill();
		}
		else{
			plataformaFlotante.revive();
		}
	}
	public function CrearDrops(drops:Drops){
		if (!(drops.Recoleccion())){
			if (!(drops.isOnScreen())){
				drops.kill();
			}
			else{
				drops.revive();
			}
		}
		else{
			drops.kill();
		}
	}
	public function CrearDropsVida(dropsVida:DropsVida){
		if (!(dropsVida.Recoleccion())){
			if (!(dropsVida.isOnScreen())){
				dropsVida.kill();
			}
			else{
				dropsVida.revive();
			}
		}
		else{
			dropsVida.kill();
		}
	}
	public function CrearTrampolin(trampolin:Trampolin){
		if (!(trampolin.isOnScreen())){
			trampolin.kill();
		}
		else{
			trampolin.revive();
		}
	}
	public function CrearSueloPeligroso(sueloPeligroso:SueloPeligroso){
		if (!(sueloPeligroso.isOnScreen())){
			sueloPeligroso.kill();
		}
		else{
			sueloPeligroso.revive();
		}
	}
	public function CrearDropFalling(dropFalling:DropFalling){
		if (!(dropFalling.Recoleccion())){
			if (!(dropFalling.isOnScreen())){
				dropFalling.kill();
			}
			else{
				dropFalling.revive();
			}
		}
		else{
			dropFalling.kill();
		}
	}
}