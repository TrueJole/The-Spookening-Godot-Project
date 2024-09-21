extends Control
@onready var center_container: CenterContainer = $CenterContainer
@onready var options_menu: Control = $OptionsMenu

func _ready() -> void:
	pass
	
func showMenu() -> void:
	show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	grab_focus()
	print()
	

func _on_resume_button_button_up() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide()


func _on_exit_button_button_up() -> void:
	get_tree().quit()


func _on_options_button_button_up() -> void:
	center_container.hide()
	options_menu.show()

func _on_options_menu_done() -> void:
	center_container.show()
