extends Camera3D

@onready var hand = $Hand
@onready var dot = $Hand/Dot
var holding: bool
var heldObject


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	
	if Input.is_action_pressed("hold"):
		var bodies = hand.get_overlapping_bodies()
		holding = true
		#print_debug(bodies)
		if (not bodies.is_empty()) and (heldObject == null):
			
			heldObject = bodies[0]
			heldObject.gravity_scale = 0
			
	
	elif heldObject != null:
		holding = false
		heldObject.gravity_scale = 1
		heldObject = null
	else:
		heldObject = null
		holding = false
	
	#print_debug('holding: ', holding)
	#print_debug('object: ', heldObject)
	if holding and (heldObject != null):
		 
		if heldObject.global_position.distance_to(dot.global_position) > 0.1:
			var vel = heldObject.global_position.direction_to(dot.global_position) * heldObject.global_position.distance_to(dot.global_position)
			#vel = (10,10,10)
			#print_debug(abs(heldObject.global_position - dot.global_position))
			heldObject.linear_velocity *= 0.5
			if heldObject.has_meta('door'):
				vel *= 1000
			else:
				vel *= 150
			
			heldObject.apply_central_force(vel)
		else:
			#print_debug(heldObject.global_position.distance_to(dot.global_position))
			heldObject.linear_velocity = Vector3(0,0,0)
