extends Camera3D

@onready var hand = $Hand
@onready var dot = $Hand/Dot
@onready var equipHand = $"../EquippedHand"
var holding: bool
var equipped: bool
var equipReached:bool
var heldObject
var originalObject
@onready var cursor = $Hand/Cursor
const CURSOR_KREIS = preload("res://Assets/Materials/Textures/Cursor Kreis.png")
const CURSOR_PUNKT = preload("res://Assets/Materials/Textures/Cursor Punkt.png")

	
func checkHand():
	var bodies = hand.get_overlapping_bodies()
	if (not bodies.is_empty()) and (heldObject == null):
		#print_debug('Kreis')
		cursor.texture = CURSOR_KREIS
	else:
		#print_debug('Punkt')
		cursor.texture = CURSOR_PUNKT
		
	
func _physics_process(_delta):
	checkHand()
	
	if Input.is_action_pressed("interact") and equipped:
		if heldObject.has_method('used'):
			heldObject.used()
	
	if Input.is_action_pressed("hold"):
		var bodies = hand.get_overlapping_bodies()
		holding = true
		if (not bodies.is_empty()) and (heldObject == null):
			heldObject = bodies[0]
			originalObject = bodies[0].duplicate()
			
			#check if object needs to be equipped -> send to lower right corner of screen
			if heldObject.has_meta('equipable'):
				if heldObject.get_meta('equipable') == true:
					equipped = true
				else:
					equipped = false
			else:
				equipped = false
			
			heldObject.angular_damp = 10
			heldObject.gravity_scale = 0
			heldObject.set_collision_mask_value(3, false)
			heldObject.set_meta('held', true)
			
	
	elif heldObject != null:
		heldObject.set_meta('held', false)
		holding = false
		heldObject.gravity_scale = 1
		heldObject.set_collision_mask_value(3, originalObject.get_collision_mask_value(3))
		heldObject.angular_damp = originalObject.angular_damp
		heldObject = null
		equipReached = false
		equipped = false
		
	else:
		heldObject = null
		holding = false
	
	if holding and (heldObject != null):
		print_debug(heldObject)
		if not equipped:
			if heldObject.global_position.distance_to(dot.global_position) > 0.01:
				var vel = heldObject.global_position.direction_to(dot.global_position) * heldObject.global_position.distance_to(dot.global_position)
				heldObject.linear_velocity *= 0.5
				vel *= heldObject.mass
				vel *= 150
				heldObject.apply_central_force(vel)
				
			else:
				heldObject.linear_velocity = Vector3(0,0,0)
		else:
			#if not equipReached:
			var vel = heldObject.global_position.direction_to(equipHand.global_position) * heldObject.global_position.distance_to(equipHand.global_position)
			heldObject.linear_velocity *= 0.5
			vel *= heldObject.mass
			#if heldObject.has_meta('door'):
			#	vel *= 1000
			#else:
			vel *= 500
			heldObject.apply_central_force(vel)
			
			heldObject.look_at(Vector3(dot.global_position.x, heldObject.global_position.y, dot.global_position.z))
			if heldObject.global_position.distance_to(equipHand.global_position) < 0.01:
				#heldObject.look_at(Vector3(dot.global_position.x, heldObject.global_position.y, dot.global_position.z))
				equipReached = true
				
