extends Area3D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var audioPlayer: AudioStreamPlayer3D = $"../AudioStreamPlayer3D"
@onready var particles: GPUParticles3D = $"../GPUParticles3D"
@onready var timer: Timer = $Timer
var spülen:bool

func on_interacted() -> void:
	if animation_player.current_animation == 'SpülenZurück' or spülen == false:
		animation_player.play("Spülen")
	
	if not audioPlayer.playing:
		audioPlayer.play()
	timer.start()
	particles.emitting = true
	spülen = true


func _on_timer_timeout() -> void:
	particles.emitting = false
	animation_player.play("SpülenZurück")
	spülen = false
