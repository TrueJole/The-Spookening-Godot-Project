extends StaticBody3D

@onready var sphere: MeshInstance3D = $Sphere
@export var CONST_SPEED: float
@export var CONST_DAMP: float
@export var speed: float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if speed > 0:
		sphere.rotation.y += speed * delta
		speed -= CONST_DAMP * delta
		print(sphere.rotation.y)



func _on_interactive_component_pressed() -> void:
	speed = CONST_SPEED
	print('set Speed')
