extends Node

@onready var player := get_parent()
@export var speed = 14
@export var fall_acceleration = 75
var target_velocity = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#FIXME: If movement is bugged, uncomment 
		#var pivot = player.get_node('Pivot')
		#pivot = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed 
	target_velocity.z = direction.z * speed
	target_velocity = target_velocity * player.transform.basis
	#target_velocity = target_velocity * 

		
	if not player.is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	player.velocity = target_velocity
	player.move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
