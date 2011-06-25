package aerys.minko.type.collada.instance
{
	import aerys.minko.scene.node.IScene;
	import aerys.minko.scene.node.mesh.Mesh;
	import aerys.minko.scene.node.skeleton.Joint;
	import aerys.minko.scene.node.skeleton.SkinnedMesh;
	import aerys.minko.type.collada.Document;
	import aerys.minko.type.collada.ressource.Controller;
	import aerys.minko.type.collada.ressource.IRessource;
	import aerys.minko.type.collada.ressource.Node;
	import aerys.minko.type.math.Matrix4x4;
	
	public class InstanceController implements IInstance
	{
		private static const NS : Namespace = 
			new Namespace("http://www.collada.org/2005/11/COLLADASchema");
		
		private var _document			: Document;
		
		private var _sourceId			: String;
		private var _name				: String;
		private var _sid				: String;
		private var _bindedSkeletonId	: String;
		
		public function InstanceController(document			: Document,
										   sourceId			: String,
										   name				: String = null,
										   sid				: String = null,
										   bindedSkeletonId	: String = null)
		{
			_document			= document;
			_sourceId			= sourceId;
			_name				= name;
			_sid				= sid;
			_bindedSkeletonId	= bindedSkeletonId;
		}
		
		public static function createFromXML(document	: Document, 
											 xml		: XML) : InstanceController
		{
			var sourceId			: String = String(xml.@url).substr(1);
			var name				: String = xml.@name;
			var sid					: String = xml.@sid;
			var bindedSkeletonId	: String = String(xml.NS::skeleton[0]).substr(1);
			
			return new InstanceController(document, sourceId, name, sid, bindedSkeletonId);
		}
		
		public function toScene() : IScene
		{
			return toSkinnedMesh();
		}
		
		public function toSkinnedMesh() : SkinnedMesh
		{
			var controller		: Controller			= Controller(ressource);
			
			var skeleton		: Joint					= _document.getNodeById(_bindedSkeletonId).toJoint();
			var mesh			: Mesh					= controller.toMesh();
			var bindShapeMatrix	: Matrix4x4				= controller.bindShapeMatrix;
			var jointNames		: Vector.<String>		= controller.jointNames;
			var invBindMatrices	: Vector.<Matrix4x4>	= controller.invBindMatrices;
			
			return new SkinnedMesh(mesh, skeleton, bindShapeMatrix, jointNames, invBindMatrices);
		}
		
		public function get ressource() : IRessource
		{
			return _document.getControllerById(_sourceId);
		}
		
	}
}
