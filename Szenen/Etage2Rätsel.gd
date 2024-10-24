extends AnimationPlayer

@export var m1: Node3D
@export var m2: Node3D
@export var m3: Node3D
@export var m4: Node3D

var s1: bool
var s2: bool
var s3: bool
var s4: bool

var locked: bool = false 

## 4213

var progress: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#play_backwards("secretEntrance")
	m1.connect('activated', update)
	m2.connect('activated', update)
	m3.connect('activated', update)
	m4.connect('activated', update)


func reset() -> void:
	#play_backwards("secretEntrance")
	print('reset')
	s1 = false
	s2 = false
	s3 = false
	s4 = false
	progress = 0


signal changed
func update() -> void:
	if not locked:
		changed.emit()
		
		if m1.spülen: 
			s1 = true
		if m2.spülen: s2 = true
		if m3.spülen: s3 = true
		if m4.spülen: 
			s4 = true
		
		if progress == 0 and !s1 and !s2  and !s3 and s4:
			progress = 1
		elif progress == 1 and !s1 and s2  and !s3 and s4:
			progress = 2
		elif progress == 2 and s1 and s2  and !s3 and s4:
			progress = 3
		elif progress == 3 and s1 and s2  and s3 and s4:
			progress = 4
			print('Gelöst!')
			play("secretEntrance")
			locked = true
		else:
			#print('reset')
			reset()
	
	print(progress, s1, s2, s3, s4)
