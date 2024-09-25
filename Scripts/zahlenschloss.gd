extends Node3D
@export var correct: String
signal opened
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int() and new_text.to_int() >= 0:
		if new_text == correct:
			opened.emit()
