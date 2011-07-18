package aerys.minko.type.parser.collada.instance
{
	import aerys.minko.ns.minko_collada;
	import aerys.minko.scene.node.IScene;
	import aerys.minko.scene.node.Model;
	import aerys.minko.scene.node.group.Group;
	import aerys.minko.scene.node.group.IGroup;
	import aerys.minko.scene.node.mesh.IMesh;
	import aerys.minko.scene.node.mesh.Mesh;
	import aerys.minko.scene.node.texture.ITexture;
	import aerys.minko.type.parser.collada.Document;
	import aerys.minko.type.parser.collada.ressource.Geometry;
	import aerys.minko.type.parser.collada.ressource.IRessource;
	import aerys.minko.type.parser.collada.store.Triangles;
	
	use namespace minko_collada;
	
	public class InstanceGeometry implements IInstance
	{
		private static const NS : Namespace = new Namespace("http://www.collada.org/2005/11/COLLADASchema");
		
		private var _document			: Document;
		private var _sourceId			: String;
		private var _name				: String;
		private var _sid				: String;
		private var _bindMaterial		: Object;
		
		private var _minkoModel			: Model;
		
		public function InstanceGeometry(document			: Document,
										 sourceId			: String,
										 bindMaterial		: Object = null,
										 name				: String = null,
										 sid				: String = null)
		{
			_document		= document;
			_sourceId		= sourceId;
			_name			= name;
			_sid			= sid;
			_bindMaterial	= bindMaterial;
		}
		
		public static function createFromXML(document	: Document,
											 xml		: XML) : InstanceGeometry
		{
			var sourceId	: String = String(xml.@url).substr(1);
			var name		: String = xml.@name;
			var sid			: String = xml.@sid;
			
			var bindMaterial : Object = new Object();
			for each (var xmlIm : XML in xml..NS::instance_material)
			{
				var instanceMaterial : InstanceMaterial = InstanceMaterial.createFromXML(xmlIm, document);
				bindMaterial[instanceMaterial.symbol] = instanceMaterial;
			}
			
			return new InstanceGeometry(document, sourceId, bindMaterial, name, sid);
		}
		
		public static function createFromSourceId(document : Document,
												  sourceId : String) : InstanceGeometry
		{
			return new InstanceGeometry(document, sourceId);
		}
		
		public function toScene() : IScene
		{
			return toUntexturedModel();
		}
		
		public function toUntexturedModel() : Model
		{
			if (!_minkoModel)
			{
				var geometryRessource	: Geometry	= ressource as Geometry;
				var mesh				: IMesh		= geometryRessource.toMesh();
				var texture				: ITexture	= null;
				
				if (mesh != null)
					_minkoModel = new Model(mesh);
			}
			
			return _minkoModel;
		}
		
		public function toTexturedModelGroup() : IGroup
		{
			var group		: Group		= new Group();
			var geometry	: Geometry	= ressource as Geometry;
			
			for each (var triangleStore : Triangles in geometry.triangleStores)
			{
				if (triangleStore.vertexCount == 0)
					continue;
				
				var subMesh				: IMesh				= geometry.toSubMesh(triangleStore);
				
				var subMeshMatSymbol	: String			= triangleStore.material;
				var instanceMaterial	: InstanceMaterial	= _bindMaterial[subMeshMatSymbol];
				var texture				: ITexture			= instanceMaterial.toScene() as ITexture;
				
				group.addChild(new Model(subMesh, texture));
				
			}
			
			return group;
		}
		
		public function get ressource() : IRessource
		{
			return _document.getGeometryById(_sourceId);
		}
	}
}