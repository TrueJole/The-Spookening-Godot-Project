extends Node3D

var kind: int = 1
@export var rainIndex: int
func _ready() -> void:
	var mesh: MeshInstance3D = $Mesh
	
	
	mesh.get_surface_override_material(rainIndex).albedo_texture = Root.rainTexture
