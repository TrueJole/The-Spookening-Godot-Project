extends Node3D
@export var state: bool
@onready var animationPlayer := $AnimationPlayer
@onready var base := $Cube

# Dieser Teil wird nur einmal am Anfang des Spiels aufgerufen
func _ready():
	# Der Schalter wird am Anfang auf die richtige Stellung gesetzt
	if state:
		animationPlayer.play("down")
	else:
		animationPlayer.play_backwards("down")

# Dieser Teil wird ausgeführt, wenn der Hebel umgelegt wird
func turned():
	if not animationPlayer.is_playing():
		# Status ändern
		state = not state
		print_debug('changed', state)
		
		# Animation abspielen (ja, ich musste auch animieren :/ )
		if state:
			animationPlayer.play("down")
		else:
			animationPlayer.play_backwards("down")
			
			
