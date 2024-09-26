extends Node3D

var kind: int = 1

func _ready() -> void:
	var mesh: MeshInstance3D = $Mesh
	
	if kind == 1:
		mesh.get_surface_override_material(1).albedo_texture = Root.rainTexture
	elif kind == 2:
		mesh.get_surface_override_material(4).albedo_texture = Root.rainTexture
