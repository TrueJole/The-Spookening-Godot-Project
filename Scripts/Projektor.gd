extends Node3D

@onready var projector: SpotLight3D = $SpotLight3D
var loaded:RigidBody3D
var justLoaded: bool


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if loaded != null:
		projector.show()
		loaded.global_position = get_node('Activation Module').global_position + Vector3(0,0.05,0)
		loaded.rotation = get_node('Activation Module').rotation + Vector3(0, deg_to_rad(90), 0)
		#var texture: Texture2D = loaded.get_meta('data')
		#projector.light_projector = texture
		#print_debug('applied: ', texture)
		loaded = null
	else:
		projector.hide()
		projector.light_projector = null
		

func activated() -> void:
	var cart: Node3D = get_node("Activation Module").lastBody
	if cart.has_meta('held') and not cart.get_meta('held'):
		loaded = cart
		if projector.light_projector == null:
			var texture: Texture2D = loaded.get_meta('data')
			projector.light_projector = texture
		
			print_debug('Projector used')
		loaded.global_position = get_node('Activation Module').global_position + Vector3(0,0.05,0)
		loaded.rotation = get_node('Activation Module').rotation + Vector3(0, deg_to_rad(90), 0)
