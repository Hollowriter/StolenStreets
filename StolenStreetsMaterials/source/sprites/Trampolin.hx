package sprites;

import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
/**
 * ...
 * @author MorenaMontero(inicial)
 */
class Trampolin extends FlxSprite {
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PuertayTrampolin__png, true, 70, 30);
		immovable = true;
		animation.add("Titilado", [0, 1], 4, true);
		animation.add("Aplastada", [4, 0], 5, true);
		animation.play("Titilado");
	}
	public function Aplastandolo(player:Jugador){
		if (player.overlaps(this)){
			animation.play("Aplastada");
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		if (animation.getByName("Aplastada").finished){
			animation.play("Titilado");
		}
	}
}