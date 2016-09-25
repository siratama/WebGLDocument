package webgldoc.load;

import js.html.CanvasElement;
import flwebgl.TextureAtlas;
import flwebgl.Player;

enum AssetsLoaderEvent
{
	LOADING;
	ERROR(number:Int);
	SUCCESS;
}

/*
 * loaded png, mp3
 */
class AssetsLoader
{
	private var player:Player;
	private var canvas:CanvasElement;
	private var result:Int;

	private var event:AssetsLoaderEvent;
	public function getEvent():AssetsLoaderEvent
	{
		var n = event;
		event = AssetsLoaderEvent.LOADING;
		return n;
	}

	public function new(player:Player, canvas:CanvasElement)
	{
		this.player = player;
		this.canvas = canvas;
	}
	public function execute(structureJson:Dynamic, textureAtlasSet:Array<TextureAtlas>)
	{
		event = AssetsLoaderEvent.LOADING;
		result = player.init(canvas, structureJson, textureAtlasSet, handleComplete);
		if(result != Player.S_OK)
			event = AssetsLoaderEvent.ERROR(result);
	}
	private function handleComplete()
	{
		event = AssetsLoaderEvent.SUCCESS;
	}
}
