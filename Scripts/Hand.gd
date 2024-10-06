extends Camera3D

@onready var hand: RayCast3D = $Hand
@onready var dot: Marker3D = $Dot
@onready var equipHand: Node3D = $"../EquippedHand"
var holding: bool
var equipped: bool
var equipReached:bool
var heldObject: RigidBody3D
var originalObject: RigidBody3D
@onready var cursor: TextureRect = $Cursor
const CURSOR_KREIS: Resource = preload("res://Assets/Materials/Textures/Cursor_Kreis.png")
const CURSOR_PUNKT: Resource = preload("res://Assets/Materials/Textures/Cursor_Punkt.png")

	
func checkHand() -> void:
	#var bodies: Array = hand.get_collider()
	if hand.is_colliding() and (heldObject == null) and ((hand.get_collider() is Area3D) or (hand.get_collider() is RigidBody3D)):
		#print_debug('Kreis')
		cursor.texture = CURSOR_KREIS
	else:
		#print_debug('Punkt')
		cursor.texture = CURSOR_PUNKT
		
	
func _physics_process(_delta: float) -> void:
	checkHand()
	
	
	if Input.is_action_pressed("interact") and equipped:
		if heldObject.has_method('used'):
			heldObject.used()
	
	if Input.is_action_pressed("hold"):
		holding = true
		
		if hand.is_colliding() and (hand.get_collider() is Area3D) and (heldObject == null):
			
			var selectedObject: Area3D = hand.get_collider()
			
			if selectedObject.has_method('on_interacted'):
				#print_debug(selectedObject)
				selectedObject.on_interacted()
		
		
		if hand.is_colliding() and (hand.get_collider() is RigidBody3D) and (heldObject == null):
			
			heldObject = hand.get_collider()
			originalObject = hand.get_collider().duplicate()
			
			if heldObject.has_method('on_pickup'):
				heldObject.on_pickup()
			
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
		heldObject.linear_velocity *= 0.5
		heldObject.angular_velocity *= 0.5
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
		#print_debug(heldObject)
		if not equipped:
			if heldObject.global_position.distance_to(dot.global_position) > 0.01:
				var vel:Vector3 = heldObject.global_position.direction_to(dot.global_position) * heldObject.global_position.distance_to(dot.global_position)
				heldObject.linear_velocity *= 0.5
				vel *= heldObject.mass
				vel *= 150
				heldObject.apply_central_force(vel)
				
			else:
				heldObject.linear_velocity = Vector3(0,0,0)
		else:
			#if not equipReached:
			var vel:Vector3 = heldObject.global_position.direction_to(equipHand.global_position) * heldObject.global_position.distance_to(equipHand.global_position)
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
				
