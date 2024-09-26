extends Node3D

signal switched
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@export var on: bool


func _on_interactive_component_pressed() -> void:
	if not on:
		animationPlayer.play("switchOn")
		on = true
	else:
		animationPlayer.play_backwards("switchOn")
		on = false
	switched.emit()
