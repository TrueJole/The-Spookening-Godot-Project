extends Node3D

@export var locked: bool
@onready var door := $"Tür"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if locked:
		door.set_collision_layer_value ( 1, true )
		door.rotation.y = 0
		door.freeze = true
	else:
		#close the door if it is nearly closed
		if snappedf(door.rotation.y, 0.1) == 0:
			door.rotation.y = 0
		#print_debug(door.rotation.y)
		door.set_collision_layer_value ( 1, false )	
		door.freeze = false
