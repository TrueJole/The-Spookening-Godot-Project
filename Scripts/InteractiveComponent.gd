extends Area3D
signal pressed

func on_interacted():
	emit_signal("pressed")
