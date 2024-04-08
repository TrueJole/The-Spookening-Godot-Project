extends Node3D
@export var state: bool
@onready var animationPlayer := $AnimationPlayer
@onready var base := $Cube

# Called when the node enters the scene tree for the first time.
func _ready():
	if state:
		animationPlayer.play("down")
	else:
		animationPlayer.play_backwards("down")

func turned():
	if not animationPlayer.is_playing():
		state = not state
		print_debug('changed', state)
		if state:
			animationPlayer.play("down")
		else:
			animationPlayer.play_backwards("down")

