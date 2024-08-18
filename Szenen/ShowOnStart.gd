extends Node3D
@export var ShowOnStart: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = ShowOnStart
