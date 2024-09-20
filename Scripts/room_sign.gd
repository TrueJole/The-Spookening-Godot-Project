@tool
extends Node3D

@onready var label_3d: Label3D = $Label3D
@onready var label_3d_2: Label3D = $Label3D2
@onready var label_3d_3: Label3D = $Label3D3

@export var roomNumber: String
@export var textUp: String
@export var textLow: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_3d.text = roomNumber
	label_3d.text = textUp
	label_3d.text = textLow
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		print('label_3d.texttest')
		label_3d.text = roomNumber
		label_3d.text = textUp
		label_3d.text = textLow
	
