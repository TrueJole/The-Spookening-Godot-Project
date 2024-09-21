extends Control

@onready var loadingBar: ProgressBar = $CenterContainer/VBoxContainer/ProgressBar
@export var nextScene: String = "res://Szenen/World.tscn"
@onready var center_container: CenterContainer = $CenterContainer

var loading: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadingBar.hide()
	#RenderingServer.viewport_set_msaa_2d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
	pass # Replace with function bosdy.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if loading:
		var progress: Array[float]
		progress.clear()
		ResourceLoader.load_threaded_get_status(nextScene, progress)
		print(progress[0])
		loadingBar.value = min(progress[0] * 100.0, 99)
		if progress[0] == 1:
			
			
			get_parent().add_child(ResourceLoader.load_threaded_get(nextScene).instantiate())
			RenderingServer.viewport_set_msaa_2d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
			queue_free()


func _on_start_button_pressed() -> void:
	if not loading:
		get_node('OptionsMenu').queue_free()
		loadingBar.show()
		print(ResourceLoader.get_dependencies(nextScene))
		ResourceLoader.load_threaded_request(nextScene, "", true)
		loading = true

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	if not loading:
		center_container.hide()
		get_node('OptionsMenu').show()


func _on_options_menu_done() -> void:
	center_container.show()
	get_node('OptionsMenu').hide()
