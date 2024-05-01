extends Node3D

@export var locked: bool
@onready var door := $"Tür"
@onready var activator := $"Activation Module"
@onready var audioPlayer := $AudioStreamPlayer3D

var closed: bool
var closeSound := preload("res://Resources/Sounds/DoorClosedRandom.tres")
var screachSound := preload("res://Resources/Sounds/DoorClosingRandom.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	#connect(get_node("Activation Module").get_signal_list().activated, _on_activation_module_activated())
	pass
	
func activated():
	locked = false
	print_debug('recieved')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if locked:
		door.set_collision_layer_value ( 1, true )
		door.rotation.y = 0
		door.freeze = true
		closed = true
	else:
		#close the door if it is nearly closed
		if snappedf(door.rotation.y, 0.1) == 0 and door.angular_velocity.y < 0.9:
			door.rotation.y = 0
			if not closed:
				door.angular_velocity = Vector3(0,0,0)
				audioPlayer.pitch_scale = 1
				audioPlayer.stream = closeSound
				audioPlayer.play()
			closed = true
		else:
			audioPlayer.pitch_scale = clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,2)
			#audioPlayer.pitch_scale = door.angular_velocity.y
			if absf(door.angular_velocity.y) > 0.02 and not audioPlayer.playing and randi_range(0,(60/clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,5))) == 0:
				audioPlayer.stream = screachSound
				audioPlayer.pitch_scale = clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,2)
				audioPlayer.play()
			elif abs(door.angular_velocity.y) <= 0.02:
				pass
				#audioPlayer.stop()
				#print_debug(door.angular_velocity.y)
				
				
			closed = false
			#door.angular_velocity = Vector3(0,0,0)
		#print_debug(door.rotation.y)
		door.set_collision_layer_value ( 1, false )	
		door.freeze = false


