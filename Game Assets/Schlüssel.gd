extends RigidBody3D
@onready var animationPlayer = $AnimationPlayer
var used: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activated():
	print_debug('used key')
	if not used:
		animationPlayer.play("turn")
	used = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if used and animationPlayer.is_playing() == false:
		queue_free()
