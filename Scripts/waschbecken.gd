extends StaticBody3D

@onready var timer: Timer = $Timer
@onready var water: GPUParticles3D = $GPUParticles3D

@onready var audioStreamPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var wasserAn: Resource = preload("res://Resources/Sounds/WasserAn.wav")
@onready var wasserLoop: Resource = preload("res://Resources/Sounds/wasserLoop.tres")
@onready var wasserAus: Resource = preload("res://Resources/Sounds/WasserAus.wav")

signal activated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water.amount_ratio = 0
	water.emitting = true


func _on_interactive_component_pressed() -> void:
	water.amount_ratio = 1
	timer.wait_time = randf_range(3, 5)
	timer.start()
	print('Wasser Marsch!')
	audioStreamPlayer.stream = wasserAn
	audioStreamPlayer.play()
	activated.emit()
	await  audioStreamPlayer.finished
	
	audioStreamPlayer.stream = wasserLoop
	audioStreamPlayer.play()


func _on_timer_timeout() -> void:
	water.amount_ratio = 0
	audioStreamPlayer.stream = wasserAus
	audioStreamPlayer.play()
	print('Halt Stop!')
