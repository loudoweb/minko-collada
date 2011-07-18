package aerys.minko.type.parser.collada.ressource.effect.technique
{
	import aerys.minko.type.parser.collada.helper.NumberListParser;
	import aerys.minko.type.parser.collada.store.CommonColorOrTexture;

	public class Phong implements ILightedTechnique
	{
		private static const NS : Namespace = new Namespace("http://www.collada.org/2005/11/COLLADASchema");
		
		private var _emission			: CommonColorOrTexture;
		private var _ambient			: CommonColorOrTexture;
		private var _diffuse			: CommonColorOrTexture;
		private var _specular			: CommonColorOrTexture;
		private var _shininess			: Number;
		private var _reflective			: CommonColorOrTexture;
		private var _reflectivity		: Number;
		private var _transparent		: CommonColorOrTexture;
		private var _transparency		: Number;
		private var _indexOfRefraction	: Number;
		
		public function get emission()			: CommonColorOrTexture	{ return _emission;				}
		public function get ambient()			: CommonColorOrTexture	{ return _ambient;				}
		public function get diffuse()			: CommonColorOrTexture	{ return _diffuse;				}
		public function get specular()			: CommonColorOrTexture	{ return _specular;				}
		public function get shininess()			: Number				{ return _shininess;			}
		public function get reflective()		: CommonColorOrTexture	{ return _reflective;			}
		public function get reflectivity()		: Number				{ return _reflectivity;			}
		public function get transparent()		: CommonColorOrTexture	{ return _transparent;			}
		public function get transparency()		: Number				{ return _transparency;			}
		public function get indexOfRefraction()	: Number				{ return _indexOfRefraction;	}
		
		public static function createFromXML(xml : XML) : Phong
		{
			var phong : Phong = new Phong();
			phong._emission				= CommonColorOrTexture.createFromXML(xml.NS::emission[0]);
			phong._ambient				= CommonColorOrTexture.createFromXML(xml.NS::ambient[0]);
			phong._diffuse				= CommonColorOrTexture.createFromXML(xml.NS::diffuse[0]);
			phong._specular				= CommonColorOrTexture.createFromXML(xml.NS::specular[0]);
			phong._shininess			= parseFloat(xml.NS::shininess[0].NS::float[0]);
			phong._reflective			= CommonColorOrTexture.createFromXML(xml.NS::reflective[0]);
			phong._reflectivity			= parseFloat(xml.NS::reflectivity[0].NS::float[0]);
			phong._transparent			= CommonColorOrTexture.createFromXML(xml.NS::transparent[0]);
			phong._transparency			= parseFloat(xml.NS::transparency[0].NS::float[0]);
			phong._indexOfRefraction	= parseFloat(xml.NS::index_of_refraction[0].NS::float[0]);
			
			return phong;
		}
	}
}