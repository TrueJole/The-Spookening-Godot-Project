extends Node3D

signal switched
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@export var on: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactive_component_pressed() -> void:
	if not on:
		animationPlayer.play("switchOn")
		on = true
	else:
		animationPlayer.play_backwards("switchOn")
		on = false
	switched.emit()
