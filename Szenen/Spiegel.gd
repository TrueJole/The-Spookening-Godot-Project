extends Node3D

@export var main_cam: Camera3D
@onready var mirror_cam: Camera3D = $SubViewport/MirrorCamera
@onready var dummy = $Pivot/Dummy
@onready var pivot = $Pivot
func _ready():
	main_cam = get_node("/root/root/World/Player/Head/Camera3D")

func _process(delta):
	
	
	if main_cam:
		scale.z *= -1
		
		pivot.global_transform = main_cam.global_transform
		
		scale.z *= -1
		mirror_cam.global_transform = dummy.global_transform
		mirror_cam.global_transform.basis.x *= -1
		
	
