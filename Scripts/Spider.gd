extends Node3D
@onready var player: CharacterBody3D = $"/root/root/World/Player"
var down: bool
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	down = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.global_position.y > global_position.y - 3:
		hide()
	
	if down and global_position.distance_to(player.global_position) < 3:
		animationPlayer.play("up")
		down = false
	elif global_position.distance_to(player.global_position) > 6 and not down:
		animationPlayer.play("down")
		down = true
