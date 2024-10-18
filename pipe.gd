extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var activated: bool = false
signal changed

func _on_activation_module_activated(_body: Node3D) -> void:
	#print('received')
	if not activated:
		animation_player.play('Open')
		changed.emit()
		activated = true
	
	
