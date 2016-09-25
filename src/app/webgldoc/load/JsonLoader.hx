package webgldoc.load;

import haxe.Json;
import js.html.XMLHttpRequest;

enum JsonLoaderEvent
{
	LOADING;
	LOAD_SUCCESS;
	LOAD_ERROR(url:String);
}
class JsonLoader
{
	private var xMLHttpRequest:XMLHttpRequest;
	private var url:String;
	public var json(default, null):Dynamic;

	private var event:JsonLoaderEvent;
	public function getEvent():JsonLoaderEvent
	{
		var n = event;
		event = JsonLoaderEvent.LOADING;
		return n;
	}

	public function new(url:String)
	{
		this.url = url;
	}
	public function execute()
	{
		event = JsonLoaderEvent.LOADING;

		xMLHttpRequest = new XMLHttpRequest();
		//xMLHttpRequest.responseType = XMLHttpRequestResponseType.JSON; //does not work in ie

		xMLHttpRequest.onreadystatechange = function()
		{
			if(xMLHttpRequest.readyState != XMLHttpRequest.DONE) return;

			if(xMLHttpRequest.status == 200){
				event = JsonLoaderEvent.LOAD_SUCCESS;
				json = Json.parse(xMLHttpRequest.response);
			}
			else{
				event = JsonLoaderEvent.LOAD_ERROR(url);
			}
		};
		xMLHttpRequest.open("GET", url, true);
		xMLHttpRequest.send();
	}
}
