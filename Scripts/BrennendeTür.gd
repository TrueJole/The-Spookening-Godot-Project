extends Node3D

@export var locked: bool
@onready var door := $"Tür"
@onready var activator := $"Activation Module"
var fireValue: float = 200
@onready var fireParticles = $FireParticles
@onready var occluder = $"Tür/OccluderInstance3D"
@onready var movingFire = $FireParticles/Anker/MovingFireLight
@onready var player = $"/root/root/Schule/Player"
@onready var anker = $FireParticles/Anker


# Called when the node enters the scene tree for the first time.
func _ready():
	movingFire.position = Vector3(-0.05, 0.56, -0.3)
	fireParticles.show()
	#connect(get_node("Activation Module").get_signal_list().activated, _on_activation_module_activated())
	pass
	
func activated():
	if fireValue > 0:
		fireValue -= 1
	print_debug('recieved', fireValue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if locked:
		if to_global(anker.position).distance_to(player.global_position) < to_global(anker.position+Vector3(0, 0, 0.2)).distance_to(player.global_position):
			movingFire.position = Vector3(0, 0, 0)
			print_debug('000')
			
		else:
			print_debug('nicht 000')
			movingFire.position = Vector3(0, 0, 0.2)
		
		if fireValue != 200 and fireValue > 0:
			fireParticles.show()
			fireParticles.amount_ratio = (fireValue-fireValue*0.5)/200
		elif fireValue <= 0:
			fireParticles.hide()
			locked = false
		door.set_collision_layer_value ( 1, true )
		door.rotation.y = 0
		door.freeze = true
		occluder.show()
	else:
		#close the door if it is nearly closed
		if snappedf(door.rotation.y, 0.1) == 0:
			door.rotation.y = 0
		#print_debug(door.rotation.y)
		fireParticles.hide()
		door.set_collision_layer_value ( 1, false )
		door.freeze = false
		occluder.hide()

