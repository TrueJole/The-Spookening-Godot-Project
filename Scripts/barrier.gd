extends StaticBody3D
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var marker_3d: Marker3D = $Marker3D


func _on_buzzer_pressed() -> void:
	gpu_particles_3d.emitting = true
	await get_tree().create_timer(0.4).timeout
	marker_3d.hide()
	await get_tree().create_timer(2).timeout
	queue_free()
