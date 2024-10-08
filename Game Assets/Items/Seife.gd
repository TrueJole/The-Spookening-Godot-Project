extends RigidBody3D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	$GPUParticles3D.emitting = not sleeping
