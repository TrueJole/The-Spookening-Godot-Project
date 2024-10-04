extends Node3D

signal pressed



func _on_interactive_component_pressed() -> void:
	pressed.emit()
	$AnimationPlayer.play("pressed")
