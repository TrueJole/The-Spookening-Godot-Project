@tool
extends EditorScript
var currentScene

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	if get_scene() != currentScene:
		currentScene = get_scene
		#TODO:set Half Res
		#EditorInterface.get_editor_viewport_3d(0).
