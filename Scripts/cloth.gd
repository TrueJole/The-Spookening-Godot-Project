extends Node3D

@onready var static_body_3d: StaticBody3D = $StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	static_body_3d.global_position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	static_body_3d.global_position.x = 10
	print(static_body_3d.position.x)
	#static_body_3d.global_position.x -= delta * 0.3

	
