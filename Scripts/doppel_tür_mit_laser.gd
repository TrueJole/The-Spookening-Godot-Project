extends Node3D

@export var locked: bool


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not locked: 
		$Barriere/CollisionShape3D.disabled = true
		$Lasers.hide()
