package webgldoc.load;

import flwebgl.TextureAtlas;
import webgldoc.load.JsonLoader.JsonLoaderEvent;
using webgldoc.load.AssetsJson.AssetsJsonUtil;

enum AssetsJsonLoaderEvent
{
	LOADING;
	ERROR(fileName:String);
	SUCCESS;
}

class AssetsJsonLoader
{
	public var textureAtlasSet(default, null):Array<TextureAtlas>;
	private var mainFunction:Void->Void;
	private var assetsJson:AssetsJson;

	private var jsonLoader:JsonLoader;
	private var assetsJsonLoader:JsonLoader;
	public var structureJsonLoader(default, null):JsonLoader;
	private var textureAtlasJsonLoader:JsonLoader;

	private var nextFunction:Void->Void;
	private var loadedIndex:Int;

	private var event:AssetsJsonLoaderEvent;
	public function getEvent():AssetsJsonLoaderEvent
	{
		var n = event;
		event = AssetsJsonLoaderEvent.LOADING;
		return n;
	}

	public function new()
	{
		textureAtlasSet = [];
		assetsJsonLoader = new JsonLoader(URI.ASSETS_JSON);
	}
	public function run()
	{
		mainFunction();
	}
	public function execute()
	{
		loadedIndex = 0;
		event = AssetsJsonLoaderEvent.LOADING;
		initializeToLoadAssetsJson();
	}

	//
	private function initializeToLoad(jsonLoader:JsonLoader, nextFunction:Void->Void)
	{
		this.jsonLoader = jsonLoader;
		this.nextFunction = nextFunction;

		jsonLoader.execute();
		mainFunction = load;
	}
	private function load()
	{
		switch(jsonLoader.getEvent()) {
			case JsonLoaderEvent.LOADING: return;
			case JsonLoaderEvent.LOAD_ERROR(url): event = AssetsJsonLoaderEvent.ERROR(url);
			case JsonLoaderEvent.LOAD_SUCCESS: nextFunction();
		}
	}

	//
	private function initializeToLoadAssetsJson()
	{
		initializeToLoad(assetsJsonLoader, finishToLoadAssetsJson);
	}
	private function finishToLoadAssetsJson()
	{
		assetsJson = assetsJsonLoader.json;
		initializeToLoadStructureJson();
	}

	//
	private function initializeToLoadStructureJson()
	{
		var structureJsonURI = assetsJson.getStructureURI();
		structureJsonLoader = new JsonLoader(structureJsonURI);
		initializeToLoad(structureJsonLoader, initializeToLoadTextureAtlasJson);
	}

	//
	private function initializeToLoadTextureAtlasJson()
	{
		var textureAtlasJsonURI = assetsJson.getTextureAtlasJsonURI(loadedIndex);
		textureAtlasJsonLoader = new JsonLoader(textureAtlasJsonURI);
		initializeToLoad(textureAtlasJsonLoader, finish);
	}

	//
	private function finish()
	{
		var textureAtlas = new TextureAtlas(
			textureAtlasJsonLoader.json,
			assetsJson.getTextureAtlasImageURI(loadedIndex)
		);
		textureAtlasSet.push(textureAtlas);

		if(loadedIndex < assetsJson.atlas.length - 1){
			loadedIndex++;
			initializeToLoadTextureAtlasJson();
		}
		else{
			event = AssetsJsonLoaderEvent.SUCCESS;
		}
	}
}
