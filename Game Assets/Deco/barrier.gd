extends StaticBody3D
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var marker_3d: Marker3D = $Marker3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_interactive_component_pressed() -> void:
	gpu_particles_3d.emitting = true
	await get_tree().create_timer(0.4).timeout
	marker_3d.hide()
	await get_tree().create_timer(2).timeout
	queue_free()
