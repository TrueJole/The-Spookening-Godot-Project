extends RigidBody3D

@onready var foamArea = $FoamArea
@onready var foam = $GPUParticles3D
@onready var animation = $AnimationPlayer


var emit: bool = false 
var emitting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	foam.emitting = false

func used():
	print_debug('used')
	emit = true
	if emitting == false:
		animation.play("feuerlöscher_an")
	emitting = true
	
func _physics_process(delta):
	if emit:
		foam.emitting = true
		emit = false
		foamArea.monitorable = true
	else:
		if emitting:
			animation.play_backwards("feuerlöscher_an")
		emitting = false
		foamArea.monitorable = false
		foam.emitting = false
		#foamArea.hide()
	
