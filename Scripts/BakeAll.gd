@tool
extends EditorScript

const VoxelGIs: Array[String] = ["res://Szenen/World.tscn"]#, "res://Szenen/OptionsMenu.tscn"]
const Occluders: Array[String] = ["res://Szenen/World.tscn"]
var originalScene: NodePath 
# Called when the script is executed (usin>g File -> Run in Script Editor).
func _run() -> void:
	if get_scene() != null:
		var originalScene: NodePath = get_scene().get_path()
	for x:String in VoxelGIs:
		EditorInterface.open_scene_from_path(x)
		var Voxel:VoxelGI = EditorInterface.get_edited_scene_root().get_node("%VoxelGI")
		Voxel.subdiv = VoxelGI.SUBDIV_512
		Voxel.bake()
		Voxel.subdiv = VoxelGI.SUBDIV_64
		print_debug('Baked ', x)
		
	
	EditorInterface.save_all_scenes()
	if originalScene != null:
		EditorInterface.open_scene_from_path(originalScene)
	print_debug('Done!')
	#if get_parent() is VoxelGI:
	#	get_parent().bake()
	#	print_debug('Baked ', get_parent())
	#else if get_parent() is OccluderInstance3D:
	#	get_parent().
