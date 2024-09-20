extends CharacterBody3D


const SNEAKSPEED: float = 1
const SPEED: float = 2
const SPRINTSPEED: float = 3

const JUMP_VELOCITY: float = 4
var GRAVITY: float = 9.81
const SENSITIVITY: float = 0.005
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

@onready var head: Marker3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var lamp: SpotLight3D= $Head/Camera3D/SpotLight3D
@onready var stepAudio: AudioStreamPlayer3D = $AudioStreamPlayer3D
var lampOn: bool = false
var previouslyOnFloor:bool
#var testX = 0

var swimming: bool = false

enum states {SNEAKING = 1, WALKING = 2, SPRINTING = 3}
var state: int

@export var walkTime: float
var walkTimer: float

func walkSound() -> void:
	stepAudio.play()
	walkTimer = walkTime * (1 + 2.0/state)

	

func _ready() -> void:
	#print_debug(node_path.get_as_property_path())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not Global.stop:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(event.relative.y * SENSITIVITY)
		#testX += (event.relative.y * SENSITIVITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(130), deg_to_rad(-130))
		#camera.rotation.x = min(max(camera.rotation.x, deg_to_rad(-130)), deg_to_rad(130))#clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		#print_debug(min(abs(camera.rotation.x), deg(130)))
		camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(100)) * (camera.rotation.x / abs(camera.rotation.x))
		

func _physics_process(delta: float) -> void:
	if not Global.stop:
		walkTimer -= delta
		
		if Input.is_action_pressed("sprint"):
			state = states.SPRINTING
		elif Input.is_action_pressed("sneak"):
			state = states.SNEAKING
		else:
			state = states.WALKING
		
		if Input.is_action_just_pressed("sneak"):
			animationPlayer.play('Sneak')
			state = states.SNEAKING
			
		if Input.is_action_just_released("sneak"):
			animationPlayer.play_backwards('Sneak')
			state = states.WALKING
		
		
		if is_on_floor() and not previouslyOnFloor:
			walkSound()
		
		if not is_on_floor():
			if swimming:
				velocity.y -= GRAVITY * delta * 0.33
			else:
				velocity.y -= GRAVITY * delta

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			walkSound()

		
		if Input.is_action_just_pressed("toggleLamp"):
			lampOn = !lampOn
			print_debug(lampOn)
			if lampOn:
				lamp.show()
			else:
				lamp.hide()

		var input_dir:Vector2 = Input.get_vector("left", "right", "forward", "backward")
		var direction:Vector3 = (head.transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
		
		
		if direction:
			if walkTimer <= 0 and is_on_floor() and abs(velocity.length()) > 0.1:
				walkSound()
				
			
			velocity.x = direction.x * state
			velocity.z = direction.z * state
		else:
			velocity.x = 0
			velocity.z = 0
		previouslyOnFloor = is_on_floor()
		move_and_slide()
