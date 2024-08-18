extends RigidBody3D

@onready var foamArea: Area3D = $FoamArea
@onready var foam: GPUParticles3D = $GPUParticles3D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D

var emit: bool = false 
var emitting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	foam.emitting = false

func used() -> void:
	print_debug('used')
	emit = true
	if emitting == false:
		animation.play("feuerlöscher_an")
	emitting = true
	
func _physics_process(_delta: float) -> void:
	if emit:
		foam.emitting = true
		emit = false
		foamArea.monitorable = true
		if not audioPlayer.playing:
			audioPlayer.play()
	else:
		audioPlayer.stop()
		if emitting:
			animation.play_backwards("feuerlöscher_an")
		emitting = false
		foamArea.monitorable = false
		foam.emitting = false
		#foamArea.hide()
	
