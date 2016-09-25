package flwebgl.geom;
extern class Rect
{
	public function new(left:Float, top:Float, width:Float, height:Float):Void;
	public function intersects(rect:Rect):Bool;

	public var left:Float;
	public var top:Float;
	public var width:Float;
	public var height:Float;
}
