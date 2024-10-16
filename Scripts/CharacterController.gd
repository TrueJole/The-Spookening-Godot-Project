extends CharacterBody3D


const SPEED = 2.5
const JUMP_VELOCITY = 4
const GRAVITY = 9.81
const SENSITIVITY = 0.005

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var lamp = $Head/Camera3D/SpotLight3D
var lampOn := true
var testX = 0

func _ready():
	#print_debug(node_path.get_as_property_path())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(event.relative.y * SENSITIVITY)
		testX += (event.relative.y * SENSITIVITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(130), deg_to_rad(-130))
		#camera.rotation.x = min(max(camera.rotation.x, deg_to_rad(-130)), deg_to_rad(130))#clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		#print_debug(min(abs(camera.rotation.x), deg(130)))
		camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(120)) * (camera.rotation.x / abs(camera.rotation.x))
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("toggleLamp"):
		lampOn = !lampOn
		if lampOn:
			lamp.show()
		else:
			lamp.hide()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
