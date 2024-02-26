extends Camera3D

@onready var hand = $Hand
@onready var dot = $Dot


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_action_pressed("hold"):
		var bodies = hand.get_overlapping_bodies()
		if not bodies.is_empty():
			var vel = bodies[0].position.direction_to(dot.position)
			#vel = (10,10,10)
			print_debug(bodies[0])
			bodies[0].apply_force(vel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	pass
	if event.is_action("hold"):
		var bodies = hand.get_overlapping_bodies()
		if not bodies.is_empty():
			var vel = bodies[0].position.direction_to(dot.position)
			#vel = (10,10,10)
			print_debug(bodies[0])
			bodies[0].apply_central_force(vel)
