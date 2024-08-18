extends Node3D

@export var locked: bool
@onready var door: RigidBody3D = $Tür

@onready var activator: Area3D = $"Activation Module"
var fireValue: float = 200
@onready var fire_particles: GPUParticles3D = $FireParticles
@onready var occluder: OccluderInstance3D = $"Tür/OccluderInstance3D"
@onready var movingFire: OmniLight3D = $FireParticles/Anker/MovingFireLight
@onready var player: CharacterBody3D = $"/root/root/World/Player"
@onready var anker: Node3D = $FireParticles/Anker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	locked = true
	movingFire.position = Vector3(-0.05, 0.56, -0.3)
	fire_particles.show()
	#connect(get_node("Activation Module").get_signal_list().activated, _on_activation_module_activated())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if locked:
		if to_global(anker.position).distance_to(player.global_position) < to_global(anker.position+Vector3(0, 0, 0.2)).distance_to(player.global_position):
			movingFire.position = Vector3(0, 0, 0)
			
		else:
			movingFire.position = Vector3(0, 0, 0.2)
		
		if fireValue != 200 and fireValue > 0:
			fire_particles.show()
			fire_particles.amount_ratio = (fireValue-fireValue*0.5)/200
		elif fireValue <= 0:
			hide()
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
		fire_particles.hide()
		door.set_collision_layer_value ( 1, false )
		door.freeze = false
		occluder.hide()



func _on_activation_module_activated() -> void:
	if fireValue > 0:
		fireValue -= 1
	print_debug('recieved', fireValue)
