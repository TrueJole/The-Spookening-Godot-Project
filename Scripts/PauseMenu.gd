extends CanvasLayer
@onready var center_container: CenterContainer = $Control/CenterContainer
@onready var options_menu: Control# = $Control/OptionsMenu
var OPTIONS_MENU: PackedScene = preload("res://Szenen/OptionsMenu.tscn")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('pauseMenu'):
		_on_resume_button_button_up()

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
	if options_menu:
		center_container.hide()
		options_menu.show()
	else:
		options_menu = OPTIONS_MENU.instantiate()
		add_child(options_menu)
		options_menu.connect('done', _on_options_menu_done)
		center_container.hide()
		options_menu.show()

func _on_options_menu_done() -> void:
	center_container.show()
	$/root/root/World._ready()
	var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.WRITE)
	file.store_var(Root.Settings, true) 
