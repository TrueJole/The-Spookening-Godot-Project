extends StaticBody3D

@onready var mesh: MeshInstance3D = $Circle
@onready var spawnpoint: Marker3D = $Marker3D

const GREEN_LIGHT_ON: Material = preload("res://Assets/Materials/GreenLightOn.tres")
const GREEN_LIGHT_OFF: Material = preload("res://Assets/Materials/GreenLightOff.tres")
const RED_LIGHT_OFF: Material = preload("res://Assets/Materials/RedLightOff.tres")
const RED_LIGHT_ON: Material = preload("res://Assets/Materials/RedLightOn.tres")

@export var default: PackedScene
@export var defaultItemID: String
@export var activated: bool

func dispenseDefault() -> void:
	var temp: Node3D = default.instantiate()
	
	temp.set_meta("itemid", defaultItemID)
	add_child(temp)
	temp.global_position = spawnpoint.global_position

func _process(_delta: float) -> void:
	if activated:
		mesh.set_surface_override_material(2, RED_LIGHT_OFF)
		mesh.set_surface_override_material(3, GREEN_LIGHT_ON)
	else:
		mesh.set_surface_override_material(2, RED_LIGHT_ON)
		mesh.set_surface_override_material(3, GREEN_LIGHT_OFF)
