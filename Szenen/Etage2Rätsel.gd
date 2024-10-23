extends AnimationPlayer

@export var m1: Node3D
@export var m2: Node3D
@export var m3: Node3D
@export var m4: Node3D

var s1: bool
var s2: bool
var s3: bool
var s4: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	m1.connect('activated', update)
	m2.connect('activated', update)
	m3.connect('activated', update)
	m4.connect('activated', update)

signal changed
func update() -> void:
	changed.emit()
	

func reset() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update()
	
	if not (s1 and s2 and s3 and s4):
		await changed
		if s1 and !s2:
			pass
	else:
		pass
		
