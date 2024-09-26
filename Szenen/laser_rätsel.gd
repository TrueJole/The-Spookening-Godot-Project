extends Node3D

@export var receiver: Array[LaserReceiver]
#const SCHLÜSSEL: PackedScene = preload("res://Game Assets/Items/Schlüssel.tscn")
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var output: StaticBody3D

var solved: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not solved:
		for x: LaserReceiver in receiver:
			if not x.activated:
				return
		
		## Spawn key
		output.dispenseDefault()
		output.activated = true
		## Play doodle
		audio_stream_player_3d.play()
		## lock puzzle
		solved = true
		print('Solved Laser Puzzle')
