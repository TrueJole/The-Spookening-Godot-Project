@tool
extends EditorScript

var duplicates: Array[Node]

func _run() -> void:
	print(get_scene().get_child_count())
	if get_scene() == null:
		return
	for scene: Node in get_scene().get_children():
		for scene2: Node in get_scene().get_children():
			if scene != scene2 and scene.global_position == scene2.global_position and scene.rotation == scene2.rotation and (not duplicates.has(scene) or not duplicates.has(scene2)) and ((not 'Fenster' in scene.name and not 'Fenster'  in scene2.name) or ('Fenster' in scene.name and 'Fenster' in scene2.name)) and ((not 'FloorTile' in scene.name and not 'FloorTile'  in scene2.name) or ('FloorTile' in scene.name and 'FloorTile' in scene2.name)):
				print(scene.name, ' - ', scene2.name)
				duplicates.append(scene)
				duplicates.append(scene2)
				#get_scene().remove_child(scene)
