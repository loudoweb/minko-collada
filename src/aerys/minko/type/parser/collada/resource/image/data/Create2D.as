package aerys.minko.type.parser.collada.resource.image.data
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;

	public class Create2D/* extends EventDispatcher*/ implements IImageData
	{
		/*private var _bitmapData	: BitmapData;
		
		public function get isLoaded()		: Boolean		{ return _bitmapData != null;	}
		public function get bitmapData()	: BitmapData	{ return _bitmapData;			}*/
		
		public function get path() : String		{ return null; }
		
		public function Create2D()
		{
			
		}
		
		public function load() : void
		{
			
		}
	}
}