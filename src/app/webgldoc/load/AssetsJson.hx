package webgldoc.load;

typedef AssetsJson = {
	var structure:String;
	var atlas:Array<Array<String>>;
}

class AssetsJsonUtil
{
	public static function getStructureURI(assetsJson:AssetsJson):String
	{
		return URI.ASSETS_DIRECTORY + assetsJson.structure;
	}
	public static function getTextureAtlasJsonURI(assetsJson:AssetsJson, textureAtlasIndex:Int):String
	{
		return URI.ASSETS_DIRECTORY + assetsJson.atlas[textureAtlasIndex][0];
	}
	public static function getTextureAtlasImageURI(assetsJson:AssetsJson, textureAtlasIndex:Int):String
	{
		return URI.ASSETS_DIRECTORY + assetsJson.atlas[textureAtlasIndex][1];
	}
}