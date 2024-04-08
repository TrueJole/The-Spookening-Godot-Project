extends Label

@onready var Settings = preload('res://Resources/globalSettings.tres')
var time: float
var frames: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Settings.showFPS:
		show()
		if time < 1:
			time += delta
			frames += 1
		else:
			text = 'FPS: ' + str(round(1/(time/frames)))
			time = 0
			frames = 0
	else:
		hide()
