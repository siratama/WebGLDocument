package webgldoc;
import flwebgl.Player;
import js.Browser;
import js.html.DOMElement;
class ErrorDisplay
{
	private var element:DOMElement;
	public function new()
	{
		element = Browser.document.getElementById("error_display");
	}
	public function isInitializedError():Bool
	{
		return untyped __js__("window.XMLHttpRequest") == null;
	}
	public function showInitializedError()
	{
		show("Your browser is not supported XMLHttpRequest.");
	}
	public function showAssetsJsonLoadError(jsonUri:String)
	{
		show("load error: " + jsonUri);
	}
	public function showAssetsLoadError(result:Int)
	{
		var message =
			(result == Player.E_CONTEXT_CREATION_FAILED) ? "Your browser is not supported WebGL.":
			(result == Player.E_REQUIRED_EXTENSION_NOT_PRESENT) ? "Your browser WebGL extension is not supported in this page.": "error";
		show(message);
	}
	private function show(message)
	{
		element.style.display = "block";
		element.innerText = message;
	}
}
