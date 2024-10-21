@tool
extends EditorPlugin

var editorSelection: EditorSelection

func _enter_tree() -> void:
	editorSelection = get_editor_interface().get_selection()
	add_tool_menu_item("Replace all selected", func():
		replace()
		)

func _exit_tree() -> void:
	remove_tool_menu_item("Replace all selected")

func replace() -> void:
	var fileDialog: FileDialog = preload("res://addons/replace_scenes/filedialog.tscn").instantiate()
	get_editor_interface().popup_dialog(fileDialog)
	
	await fileDialog.file_selected
	var replacement: PackedScene = load(fileDialog.current_path)
	
	if replacement.instantiate() is not Node3D:
		print_debug('Replacement is not a Node3D')
		return
	
	var selected: Array[Node] = editorSelection.get_selected_nodes() 
		
	for scene: Node in selected:
		## Don't free root node of the scene, will lead to corruption
		if not scene == get_editor_interface().get_edited_scene_root() and scene is Node3D:
			var temp: Node3D = replacement.instantiate()
			scene.add_sibling(temp, true)
			temp.transform = scene.transform
			temp.owner = scene.owner
			
			scene.queue_free()
			
			## optionally copy all the metadata
			#for meta: StringName in scene.get_meta_list():
			#	temp.set_meta(meta, scene.get_meta(meta))
