extends SpotLight3D

@export_range(0, 30) var baseTime: int
@export_range(0, 10) var randomTime: int

@export_range(0, 5) var lowerFlicks: int
@export_range(0, 5) var upperFlicks: int

@export_range(0, 5) var outTime: float
@export_range(0, 5) var onTime: float

@export var showIfHidden: bool

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('test')
	while true:
		await get_tree().create_timer(baseTime + randf_range(-randomTime, randomTime)).timeout
		flicker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func flicker() -> void:
	if visible or showIfHidden:
		#print('flicker')
		for x: int in range(randi_range(lowerFlicks, upperFlicks)):
			hide()
			await get_tree().create_timer(outTime).timeout
			show()
			await get_tree().create_timer(onTime).timeout
