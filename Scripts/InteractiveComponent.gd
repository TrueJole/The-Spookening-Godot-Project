extends Area3D
signal pressed

func on_interacted() -> void:
	pressed.emit()
