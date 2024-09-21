extends Node3D
@export var state: bool
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
#@onready var base := $Cube
signal changed(state: bool)

# Dieser Teil wird nur einmal am Anfang des Spiels aufgerufen
func _ready() -> void:
	# Der Schalter wird am Anfang auf die richtige Stellung gesetzt
	if state:
		animationPlayer.play("down")
	else:
		animationPlayer.play_backwards("down")

func _on_interactive_component_pressed() -> void:
	if not animationPlayer.is_playing():
		# Status ändern
		state = not state
		print_debug('changed', state)
		changed.emit(state)
		# Animation abspielen (ja, ich musste auch animieren :/ )
		if state:
			animationPlayer.play("down")
		else:
			animationPlayer.play_backwards("down")
