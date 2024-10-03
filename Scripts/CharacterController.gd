extends CharacterBody3D


const SNEAKSPEED: float = 1
const SPEED: float = 2
const SPRINTSPEED: float = 3

const JUMP_VELOCITY: float = 4
var GRAVITY: float = 9.81
const SENSITIVITY: float = 0.005
const JOY_SENSITIVITY: float = 0.02

#@onready var pause_menu1: CanvasLayer = get_node('/root/root/PauseMenu')
#@onready var pause_menu2: CanvasLayer = $PauseMenu
const PAUSE_MENU: PackedScene = preload("res://Szenen/PauseMenu.tscn")

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

@onready var head: Marker3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var lamp: SpotLight3D= $Head/Camera3D/SpotLight3D
@onready var stepAudio: AudioStreamPlayer3D = $AudioStreamPlayer3D
var lampOn: bool = false
var previouslyOnFloor:bool
#var testX = 0

@onready var waterOverlay: ColorRect = $Head/Camera3D/WaterOverlay


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
	print('VSYNC MODE ', DisplayServer.window_get_vsync_mode(DisplayServer.get_window_list()[0]), ' - ', Engine.max_fps)
	print('3D Scale ', get_tree().root.scaling_3d_scale)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * Root.Settings.mousesens)
		camera.rotate_x(event.relative.y * Root.Settings.mousesens)
		#testX += (event.relative.y * SENSITIVITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(130), deg_to_rad(-130))
		#camera.rotation.x = min(max(camera.rotation.x, deg_to_rad(-130)), deg_to_rad(130))#clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		#print_debug(min(abs(camera.rotation.x), deg(130)))
		camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(100)) * (camera.rotation.x / abs(camera.rotation.x))
	#elif event is InputEventJoypadMotion:
		#if event.axis == JOY_AXIS_RIGHT_Y:
			#camera.rotate_x(event.axis_value * SENSITIVITY * 10)
			#camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(100)) * (camera.rotation.x / abs(camera.rotation.x))
		#elif event.axis == JOY_AXIS_RIGHT_X: 
			#head.rotate_y(-event.axis_value * SENSITIVITY * 10)
			#camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(100)) * (camera.rotation.x / abs(camera.rotation.x))
			#

			
func _physics_process(delta: float) -> void:
	camera.rotate_x(-Input.get_axis("joyDown", "joyUp") * JOY_SENSITIVITY * delta * 100)
	head.rotate_y(-Input.get_axis("joyLeft", "joyRight") * JOY_SENSITIVITY * delta * 100)
	camera.rotation.x = max(abs(camera.rotation.x), deg_to_rad(100)) * (camera.rotation.x / abs(camera.rotation.x))
	
	walkTimer -= delta
	
	if Input.is_action_pressed("sprint"):
		state = states.SPRINTING
	elif Input.is_action_pressed("sneak"):
		state = states.SNEAKING
	else:
		state = states.WALKING
	
	if Input.is_action_just_pressed("pauseMenu"):
		var temp: CanvasLayer = PAUSE_MENU.instantiate()
		add_child(temp)
		temp.showMenu()
		#pause_menu2.showMenu()
		#pass
		
		#var temp: Control = PAUSE_MENU.instantiate()
		#temp.process_mode = Node.PROCESS_MODE_ALWAYS
		#add_child(temp)
		
	
	if Input.is_action_just_pressed("sneak"):
		animationPlayer.play('Sneak')
		state = states.SNEAKING
		
	if Input.is_action_just_released("sneak"):
		animationPlayer.play_backwards('Sneak')
		state = states.WALKING
	
	
	if is_on_floor() and not previouslyOnFloor:
		walkSound()
	
	waterOverlay.visible = swimming
	
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
