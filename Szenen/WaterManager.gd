extends Node3D

@onready var pipe: StaticBody3D = $Pipe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pipe.activated:
		show()
