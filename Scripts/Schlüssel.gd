extends RigidBody3D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var used: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func activated(origin: Area3D) -> void:
	#print_debug('used key')
	if not used:
		#rotation.z = -90
		
		rotation = (origin.rotation)
		rotation.y += deg_to_rad(180)
		#position = origin.global_position
		#position += global_transform.basis * Vector3(0,,0)
		
		axis_lock_linear_x = true
		axis_lock_linear_y = true
		axis_lock_linear_z = true
		axis_lock_linear_y = true
		axis_lock_linear_z = true
		animationPlayer.play("turn")
	used = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if used and animationPlayer.is_playing() == false:
		queue_free()
