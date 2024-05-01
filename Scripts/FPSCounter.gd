extends Label
@onready var Settings := preload('res://Resources/globalSettings.tres')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Settings.showFPS:
		show()
		text = 'FPS: ' + str(Engine.get_frames_per_second())
	else:
		hide()
