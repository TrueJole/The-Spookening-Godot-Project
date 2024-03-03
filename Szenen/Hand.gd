extends Camera3D

@onready var hand = $Hand
@onready var dot = $Hand/Dot
var holding: bool
var heldObject
var heldObjectPlayerCollision:bool
var heldObjectAngularDamp:float

func _physics_process(delta):
	if Input.is_action_pressed("hold"):
		var bodies = hand.get_overlapping_bodies()
		holding = true
		if (not bodies.is_empty()) and (heldObject == null):
			heldObject = bodies[0]
			heldObjectAngularDamp = heldObject.angular_damp
			
			heldObject.angular_damp = 10
			heldObject.gravity_scale = 0
			heldObjectPlayerCollision = heldObject.get_collision_mask_value(3)
			heldObject.set_collision_mask_value(3, false)
			
	
	elif heldObject != null:
		holding = false
		heldObject.gravity_scale = 1
		heldObject.set_collision_mask_value(3, heldObjectPlayerCollision)
		heldObject.angular_damp = heldObjectAngularDamp
		heldObject = null
		
	else:
		heldObject = null
		holding = false
	
	if holding and (heldObject != null):
		if heldObject.global_position.distance_to(dot.global_position) > 0.01:
			var vel = heldObject.global_position.direction_to(dot.global_position) * heldObject.global_position.distance_to(dot.global_position)
			heldObject.linear_velocity *= 0.5
			vel *= heldObject.mass
			#if heldObject.has_meta('door'):
			#	vel *= 1000
			#else:
			vel *= 150
			heldObject.apply_central_force(vel)
			
		else:
			heldObject.linear_velocity = Vector3(0,0,0)
