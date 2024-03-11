extends Control

@onready var loadingBar = $AspectRatioContainer/VBoxContainer/MarginContainer/ProgressBar
@export var nextScene = "res://Szenen/World.tscn"

var loading: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	loadingBar.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if loading:
		var progress: Array
		ResourceLoader.load_threaded_get_status(nextScene, progress)
		loadingBar.value = progress[0] * 100
		if progress[0] == 1:
			
			
			get_parent().add_child(ResourceLoader.load_threaded_get(nextScene).instantiate())
			queue_free()


func _on_start_button_pressed():
	loadingBar.show()
	ResourceLoader.load_threaded_request(nextScene)
	loading = true

func _on_exit_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	hide()
	get_parent().get_node('OptionsMenu').show()
