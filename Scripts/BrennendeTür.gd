extends Tür


@onready var activator: Area3D = $"Activation Module"
var fireValue: float = 200
@onready var fire_particles: GPUParticles3D = $FireParticles

@onready var movingFire: OmniLight3D = $FireParticles/Anker/MovingFireLight
@onready var player: CharacterBody3D = $"/root/root/World/Player"
@onready var anker: Node3D = $FireParticles/Anker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movingFire.position = Vector3(-0.05, 0.56, -0.3)
	fire_particles.show()
	
	#connect(get_node("Activation Module").get_signal_list().activated, _on_activation_module_activated())

func basicDoorFunc() -> void:
	super()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	basicDoorFunc()
	
	if locked:
		if fireValue != 200 and fireValue > 0:
			fire_particles.show()
			fire_particles.amount_ratio = (fireValue-fireValue*0.5)/200
		elif fireValue <= 0:
			fire_particles.hide()
			locked = false
	else:
		fire_particles.hide()
	
	



func _on_activation_module_activated(_body: Node3D) -> void:
	if fireValue > 0:
		fireValue -= 1
	print('löschen')
	#print_debug('recieved', fireValue)
