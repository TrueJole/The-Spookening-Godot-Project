extends StaticBody3D
class_name Barrier
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var marker_3d: Marker3D = $Marker3D



func _on_buzzer_pressed() -> void:
	#print('PRESSED', self.name, get_parent_node_3d().name)
	gpu_particles_3d.emitting = true
	await get_tree().create_timer(0.4).timeout
	marker_3d.hide()
	await get_tree().create_timer(1).timeout
	call_deferred('free')
	#queue_free()
