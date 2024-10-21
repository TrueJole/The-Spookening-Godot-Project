@tool
extends EditorScript

var duplicates: Array[Node]

func _run() -> void:
	var eds: EditorSelection = get_editor_interface().get_selection()
	#eds.connect("selection_changed", self, "_on_selection_changed")
	print(eds.get_selected_nodes().size())
	
	var selected: Array[Node] = eds.get_selected_nodes() 

	var replacement: PackedScene
	
	if selected.is_empty():
		return
		
	for scene: Node in selected:
		#var temp: Node3D = replacement.instantiate()
		#get_scene().add_child(temp)
		#temp.transform = scene.transform
		for meta: StringName in scene.get_meta_list():
			print(meta)
		
