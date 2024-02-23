@tool
extends StaticBody3D
@onready var leftFace = $middleFace/leftFace
@onready var rightFace = $middleFace/rightFace

@export_range(0, 1) var leftRotation:float
@export_range(0, 1) var rightRotation:float

# Called when the node enters the scene tree for the first time.
func _ready():
	leftFace.rotation.y = (3.14 * leftRotation)
	rightFace.rotation.y = (-3.14 + 3.14 * (1- rightRotation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		leftFace.rotation.y = (3.14 * leftRotation)
		rightFace.rotation.y = (-3.14 + 3.14 * (1- rightRotation))
