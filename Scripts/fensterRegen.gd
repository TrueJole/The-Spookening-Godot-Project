extends Node3D

var kind: int = 1

func _ready() -> void:
	var mesh: MeshInstance3D = $Cube
	if not mesh:
		mesh = $"Wand 2 * 4"
		kind = 2
	#REGEN_GLAS.setup_local_to_scene()
	#var temp: ViewportTexture = ViewportTexture.new()
	#temp.setup_local_to_scene()
	print(self.get_path_to(Root.rain))
	#temp.set_viewport_path_in_scene(self.get_path_to(Root.rain))
	#REGEN_GLAS.resource_local_to_scene = true
	#temp.resource_local_to_scene = true
	#REGEN_GLAS.albedo_texture = Root.rain.get_texture()
	if kind == 1:
		mesh.get_surface_override_material(1).albedo_texture = Root.rainTexture
	elif kind == 2:
		mesh.get_surface_override_material(4).albedo_texture = Root.rainTexture
