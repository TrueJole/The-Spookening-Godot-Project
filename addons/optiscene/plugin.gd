@tool
extends EditorPlugin

const MULTIMESH_CONVERTER:PackedScene = preload("res://addons/optiscene/multimesh_converter.tscn")
var multimesh_converter:MultiMeshConverterWindow = MULTIMESH_CONVERTER.instantiate()


signal thread_finished(collections:Array[Array])

func place_multimeshes(root:Node, selections:Array[MeshInstance3D] = []):
	if !selections:
		if root is not Node3D:
			push_warning("Root of scene is not Node3D but '", root, "' instead. Continuing...")
		var all_nodes:Array[Node] = get_all_children(root)
		var nodes_with_children:Array[Node]
		for node:Node in all_nodes:
			if node and node.get_child_count() > 1:
				nodes_with_children.append(node)
		nodes_with_children.append(root)
		multimesh_converter = MULTIMESH_CONVERTER.instantiate().duplicate()
		get_editor_interface().popup_dialog(multimesh_converter)
		var collections:Array[Array] =  []
		for node in nodes_with_children:
			var mesh_nodes:Array[MeshInstance3D] = []
			var children:Array[Node] = node.get_children()
			for child in children:
				if child is MeshInstance3D and !child.get_script():
					mesh_nodes.append(child)
			var similars:Array[Array]
			for mesh in mesh_nodes:
				var found_same:bool = false
				for similar in similars:
					if similar[0].mesh == mesh.mesh:
						found_same = true
						break
				if found_same:
					continue
				var others:Array[MeshInstance3D] = mesh_nodes.duplicate()
				others.erase(mesh)
				var collection:Array[MeshInstance3D] = [mesh]
				for other in others:
					if mesh.mesh == other.mesh and (other.get_child_count() == 0 or\
					(other.get_child_count() == 1 and other.get_child(0) is StaticBody3D)):
						collection.append(other)
				if !(collection.size() <= 1):
					similars.append(collection)
			if similars.size() != 0:
				collections.append(similars)
		multimesh_converter.set_mesh_collections(collections)
	else:
		var collection:Array[Array] = [[selections]]
		multimesh_converter.set_mesh_collections(collection)


func get_all_children(in_node:Node, array:Array[Node]= [], is_first:bool = true):
	array.push_back(in_node)
	if in_node and (in_node.scene_file_path == "" or is_first):
		for child in in_node.get_children():
			array = get_all_children(child, array, false)
	return array



func _enter_tree() -> void:
	add_tool_menu_item("Summarize MeshInstance3Ds", func():
		place_multimeshes(get_tree().edited_scene_root)
		)


func _exit_tree() -> void:
	remove_tool_menu_item("Summarize MeshInstance3Ds")
