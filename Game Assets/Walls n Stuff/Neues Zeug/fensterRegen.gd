extends Node3D

var rain: Material = preload("res://Assets/Materials/rainMaterial.tres")
@onready var mesh: MeshInstance3D = $Cube

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp: ViewportTexture = ViewportTexture.new()
	temp.viewport_path = "/root/root/World/RainRenderer"
	mesh.get_surface_override_material(1).albedo_texture = temp
	print(get_node("/root/root/World/RainRenderer").name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
