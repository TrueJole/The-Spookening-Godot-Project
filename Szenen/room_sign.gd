@tool
extends Node3D

@onready var label_3d: Label3D = $Label3D
@export var roomNumber: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_3d.text = roomNumber


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		print('label_3d.text')
		label_3d.text = roomNumber
	
		
