extends Node

@export var rain: SubViewport
@export var rainTexture: ViewportTexture

func _ready() -> void:
	rain = get_node("/root/root/SubViewport")
	rainTexture = rain.get_texture()
	print('Rain: ', rain)

func _process(delta: float) -> void:
	#print('Rain: ', rain)
	pass

func on_scene_loaded() -> void:
	pass
