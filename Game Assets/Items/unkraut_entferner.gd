extends RigidBody3D

@onready var sprayArea: Area3D = $SprayArea
@onready var particles: GPUParticles3D = $GPUParticles3D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D

var emit: bool = false 
var emitting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particles.emitting = false

func used() -> void:
	print_debug('used')
	emit = true
	if emitting == false:
		animation.play("on")
	emitting = true
	
func _physics_process(_delta: float) -> void:
	if emit:
		particles.emitting = true
		emit = false
		sprayArea.monitorable = true
		if not audioPlayer.playing:
			audioPlayer.play()
	else:
		audioPlayer.stop()
		if emitting:
			animation.play_backwards("on")
		emitting = false
		sprayArea.monitorable = false
		particles.emitting = false
		#foamArea.hide()
	
