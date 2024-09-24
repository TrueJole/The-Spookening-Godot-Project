extends Node3D

var kind: int = 1

func _ready() -> void:
	var mesh: MeshInstance3D = $Cube
	if not mesh:
		mesh = $"Wand 2 * 4"
		kind = 2
	
	if kind == 1:
		mesh.get_surface_override_material(1).albedo_texture = Root.rainTexture
	elif kind == 2:
		mesh.get_surface_override_material(4).albedo_texture = Root.rainTexture
