package webgldoc;
import js.html.CanvasElement;
import flwebgl.geom.Rect;
import webgldoc.load.AssetsJsonLoader;
import webgldoc.load.AssetsLoader;
import flwebgl.Player;
import js.Browser;
import haxe.Timer;
class Main
{
	public static inline var FPS = 24;

	private var mainFunction:Void->Void;
	private var timer:Timer;

	private var player:Player;
	private var canvas:CanvasElement;
	private var errorDisplay:ErrorDisplay;

	private var assetsJsonLoader:AssetsJsonLoader;
	private var assetsLoader:AssetsLoader;

	public static function main()
	{
		Browser.document.addEventListener("DOMContentLoaded", function(){
			new Main();
		});
	}
	public function new()
	{
		errorDisplay = new ErrorDisplay();
		if(errorDisplay.isInitializedError()){
			errorDisplay.showInitializedError();
			return;
		}

		player = new Player();
		canvas = cast Browser.document.getElementById("canvas");

		assetsJsonLoader = new AssetsJsonLoader();
		assetsLoader = new AssetsLoader(player, canvas);

		mainFunction = initializeToLoadAssetsJson;
		timer = new Timer(Std.int(1 / FPS * 1000));
		timer.run = function(){ run(); };
	}
	private function run()
	{
		mainFunction();
	}
	
	//
	private function initializeToLoadAssetsJson()
	{
		assetsJsonLoader.execute();
		mainFunction = loadAssetsJson;
	}
	private function loadAssetsJson()
	{
		assetsJsonLoader.run();
		switch(assetsJsonLoader.getEvent())
		{
			case AssetsJsonLoaderEvent.LOADING: return;
			case AssetsJsonLoaderEvent.ERROR(jsonUri): showAssetsJsonLoadError(jsonUri);
			case AssetsJsonLoaderEvent.SUCCESS:
				initializeToLoadAssets();
		}
	}
	private function showAssetsJsonLoadError(jsonUri:String)
	{
		errorDisplay.showAssetsJsonLoadError(jsonUri);
		timer.stop();
	}

	//
	private function initializeToLoadAssets()
	{
		assetsLoader.execute(assetsJsonLoader.structureJsonLoader.json, assetsJsonLoader.textureAtlasSet);
		mainFunction = loadAssets;
	}
	private function loadAssets()
	{
		switch(assetsLoader.getEvent())
		{
			case AssetsLoaderEvent.LOADING: return;
			case AssetsLoaderEvent.ERROR(result): showAssetsLoadError(result);
			case AssetsLoaderEvent.SUCCESS: initializeToPlay();
		}
	}
	private function showAssetsLoadError(playerInitializedResult:Int)
	{
		errorDisplay.showAssetsLoadError(playerInitializedResult);
		timer.stop();
	}

	//
	private function initializeToPlay()
	{
		var width = player.getStageWidth();
		var height = player.getStageHeight();
		canvas.width = width;
		canvas.height = height;
		player.setViewport(new Rect(0, 0, width, height));

		player.play();

		/*
		var scenegraphFactory =  player.getScenegraphFactory();
		var movieMC = scenegraphFactory.createMovieClipInstance("movie.Movie");

		var matrix = new Matrix();
		matrix.scale(2, 2);
		movieMC.setLocalTransform(matrix);

		player.getStage().addChild(movieMC);
		*/

		mainFunction = play;
	}
	private function play()
	{
	}
}
