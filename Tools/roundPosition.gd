@tool
extends EditorScript


func _run() -> void:
	print(get_scene().get_child_count())
	if get_scene() == null:
		return
	for scene: Node3D in get_scene().get_children():
			if 'Fenster2' in scene.name and round(scene.position) != scene.position:
				print(scene.name, ' - ', scene.position)
				
				#scene.position = round(scene.position)
