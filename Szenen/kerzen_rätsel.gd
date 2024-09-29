extends Node

@export var candles1: Array[Candle]
@export var candles2: Array[Candle]
@export var glassball: StaticBody3D
@export var pipe: StaticBody3D
@export var water: Node
var candleLocked: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c: Candle in candles2:
		c.connect("changed", changed)
	pipe.connect("changed", pipechanged)
	glassball.activated = false
	water.hide()
	changed()
	pipechanged()

func pipechanged() -> void:
	if pipe.activated:
		water.show()
		$"../Wasser/Area3D/CollisionShape3D".disabled = false
		print('show Water')
	else:
		water.hide()
		$"../Wasser/Area3D/CollisionShape3D".disabled = true

func changed() -> void:
	if not candleLocked:
		var complete: bool = true
		for index: int in range(candles1.size()):
			candles1[index].lit = candles2[index].lit
			if not candles2[index].lit:
				complete = false
				
		if complete:
			glassball.activated = true
			$AudioStreamPlayer3D.play()
			candleLocked = true
			#water.show()
	
