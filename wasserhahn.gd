extends Node3D

@export var kessel: StaticBody3D
var emitting: bool

func _on_interactive_component_pressed() -> void:
	if not emitting:
		emitting = true
		$GPUParticles3D.emitting = true
		kessel.fill()
		$AudioStreamPlayer3D.play()
		await get_tree().create_timer(2.5).timeout
		$GPUParticles3D.emitting = false
		await get_tree().create_timer(0.5).timeout
		$AudioStreamPlayer3D.stop()
		emitting = false
