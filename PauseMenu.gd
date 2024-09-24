extends CanvasLayer
@onready var center_container: CenterContainer = $Control/CenterContainer
@onready var options_menu: Control = $Control/OptionsMenu

func _ready() -> void:
	pass
	

	
func showMenu() -> void:
	show()
	#$CanvasLayer.show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#grab_focus()
	#print('Test')
	

func _on_resume_button_button_up() -> void:
	#print('Test2')
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$CanvasLayer.hide()
	
	hide()
	queue_free()
		

func _on_exit_button_button_up() -> void:
	get_tree().quit()


func _on_options_button_button_up() -> void:
	center_container.hide()
	options_menu.show()

func _on_options_menu_done() -> void:
	center_container.show()
