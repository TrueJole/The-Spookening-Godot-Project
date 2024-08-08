extends Area3D
@onready var animation_player = $"../AnimationPlayer"
@onready var audioPlayer = $"../AudioStreamPlayer3D"
@onready var particles = $"../GPUParticles3D"
@onready var timer = $Timer
var spülen:bool

func on_interacted():
	if animation_player.current_animation == 'SpülenZurück' or spülen == false:
		animation_player.play("Spülen")
	
	if not audioPlayer.playing:
		audioPlayer.play()
	timer.start()
	particles.emitting = true
	spülen = true


func _on_timer_timeout():
	particles.emitting = false
	animation_player.play("SpülenZurück")
	spülen = false
