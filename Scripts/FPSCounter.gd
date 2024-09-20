extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Root.Settings.showFPS:
		show()
		text = 'FPS: ' + str(Engine.get_frames_per_second())
	else:
		hide()
