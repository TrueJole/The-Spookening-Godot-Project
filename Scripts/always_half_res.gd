@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).


func _run() -> void:
	EditorInterface.get_editor_viewport_3d(0).scaling_3d_scale = 0.8
	print_debug('Applied Half Res')
