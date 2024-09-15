extends StaticBody3D

@onready var timer: Timer = $Timer
@onready var water: GPUParticles3D = $GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water.amount_ratio = 0
	water.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactive_component_pressed() -> void:
	water.amount_ratio = 1
	timer.wait_time = randf_range(3, 5)
	timer.start()
	print('Wasser Marsch!')


func _on_timer_timeout() -> void:
	water.amount_ratio = 0
	print('Halt Stop!')
