package flwebgl;
import flwebgl.geom.Rect;
import js.html.CanvasElement;
extern class Player
{
	public function new():Void;
	public function play():Void;
	public function init(canvas:CanvasElement, resourceFile:Dynamic, textureAtlasSet:Array<TextureAtlas>, callback:Void->Void):Int;
	public function getStageWidth():Int;
	public function getStageHeight():Int;
	public function setViewport(viewport:Rect):Void;
	public function getScenegraphFactory():SceneGraphFactory;
	public function getStage():MovieClip;

	public static var S_OK:Int;
	public static var E_ERR:Int;
	public static var E_INVALID_PARAM:Int;
	public static var E_CONTEXT_CREATION_FAILED:Int;
	public static var E_REQUIRED_EXTENSION_NOT_PRESENT:Int;
	public static var E_RESOURCE_LOADING_FAILED:Int;
}
