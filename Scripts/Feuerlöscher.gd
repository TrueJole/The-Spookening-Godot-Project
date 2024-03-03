extends RigidBody3D

@onready var foamArea = $FoamArea
@onready var foam = $GPUParticles3D

var emit: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	foam.emitting = false

func used():
	print_debug('used')
	emit = true
	
func _physics_process(delta):
	if emit:
		foam.emitting = true
		emit = false
		foamArea.monitorable = true
	else:
		foamArea.monitorable = false
		foam.emitting = false
		#foamArea.hide()
	
