extends Node3D


@onready var item_list: ItemList = $Control/ItemList
@onready var marker_3d: Marker3D = $Marker3D
var entering: bool = false
var input: String
var coins: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_list.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactive_component_pressed() -> void:
	if coins > 0:
		get_tree().paused = true
		item_list.show()
		item_list.grab_focus()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		input = ""
		#entering = true
		#set_process(false)


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	input += item_list.get_item_text(index)
	var path: String = ''
	match input:
		"77":
			path = "res://Game Assets/Items/Schlüssel.tscn"
		"11":
			path = "res://Game Assets/Items/Donut.tscn"
		"22": 
			path = "res://Game Assets/Items/Flasche.tscn"
		_ when len(input) >= 2: 
			path = "res://Game Assets/Items/Coin.tscn"
	if path:
		coins -= 1
		var temp: Node3D = load(path).instantiate()
		add_sibling(temp)
		temp.global_position = marker_3d.global_position
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		item_list.hide()
		set_process(true)
		get_tree().paused = false
		await get_tree().create_timer(1).timeout  
		entering = false

		

func _on_activation_module_activated(body: Node3D) -> void:
	coins += 1
	body.queue_free()
