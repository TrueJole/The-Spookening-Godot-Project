extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var activated: bool = false


func _on_activation_module_activated(body: Node3D) -> void:
	animation_player.play('open')
	
