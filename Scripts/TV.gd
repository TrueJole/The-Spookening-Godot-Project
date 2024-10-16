extends Node3D


var loaded
var justLoaded: bool
@onready var sub_viewport = $SubViewport
@onready var video_stream_player = $SubViewport/VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if loaded != null:
		loaded.global_position = get_node('Activation Module').global_position + Vector3(0,0,0)
		loaded.rotation = Vector3(deg_to_rad(270),deg_to_rad(180),deg_to_rad(180))

		#var texture: Texture2D = loaded.get_meta('data')
		
		#print_debug('applied: ', texture)
		loaded = null
	else:
		video_stream_player.stop()
		pass
		#projector.light_projector = null
		

func activated():
	var cart = get_node("Activation Module").lastBody
	
	if cart.has_meta('held') and not cart.get_meta('held'):
		
		if not video_stream_player.is_playing():
			
			video_stream_player.stream = (cart.get_meta('data'))
			video_stream_player.play()
			
		loaded = cart
		print_debug('used')
