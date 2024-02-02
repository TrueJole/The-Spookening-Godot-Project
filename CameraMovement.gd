extends Camera3D

@onready var player = get_parent().get_parent()
@onready var pivot = get_parent()
@export var lookaroundSpeed = 0.0001



var xRotation:float = 0
var yRotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event):
	#print('Event')
	if event is InputEventMouseMotion:
		#print('Mouse Moved')
		
		xRotation += event.relative.x * lookaroundSpeed
		yRotation += event.relative.y * lookaroundSpeed
		print(xRotation)
		transform.basis = Basis() # reset rotation
		player.rotate_object_local(Vector3(0, 1, 0), -xRotation) # first rotate in Y
		player.rotate_object_local(Vector3(1, 0, 0), yRotation) # then rotate in X

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
