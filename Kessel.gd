extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var content_mesh: MeshInstance3D = $ContentMesh

@export var item_ids: Array[String]
@export var colors: Array[Color]
@export var fulfilled: Array[bool]

@export var failedColor: Color
@export var baseColor: Color

const SPÜLUNG: Resource = preload("res://Resources/Sounds/Spülung.wav")
const PUZZLE_SOLVED_JINGLE: Resource  = preload("res://Resources/Sounds/PuzzleSolvedJingle.wav")
const UNKRAUT_ENTFERNER: PackedScene = preload("res://Game Assets/Items/UnkrautEntferner.tscn")

var done: bool
var filled: bool
var failed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setColor(baseColor)
	fulfilled.resize(item_ids.size())
	fulfilled.fill(false)

func setColor(c: Color) -> void:
	var temp: BaseMaterial3D = content_mesh.get_surface_override_material(0)
	temp.albedo_color = c
	content_mesh.set_surface_override_material(0, temp)
	

func fill() -> void:
	setColor(baseColor)
	print_debug('Filling, before ', filled)
	if not filled:
		content_mesh.show()
		animation_player.play('fill')
		filled = true
		
	
func clear() -> void:
	if filled:
		animation_player.play_backwards('fill')
		filled = false
		fulfilled.fill(false)
		failed = false
		$AudioStreamPlayer3D.stream = SPÜLUNG
		$AudioStreamPlayer3D.play()


func _on_activation_module_activated(body: Node3D) -> void:
	print_debug(not done, not failed, filled, body.has_meta('itemid'), body.get_meta('itemid') in item_ids)
	if not done and not failed and filled and body.has_meta('itemid') and body.get_meta('itemid') in item_ids:
		
		$BubbleParticles.emitting = true
		setColor(colors[item_ids.find(body.get_meta('itemid'))])
		fulfilled[item_ids.find(body.get_meta('itemid'))] = true
		body.queue_free()
	elif not done and filled:
		print_debug('Failed ', body)
		failed = true
		setColor(failedColor)
		body.queue_free()
		
	if not done and not failed and fulfilled.find(false) == -1:
		print_debug('Done')
		$BubbleParticles.amount = 100
		$BubbleParticles.emitting = true
		done = true
		content_mesh.hide()
		var temp: RigidBody3D = UNKRAUT_ENTFERNER.instantiate()
		add_child(temp)
		temp.global_position = $Marker3D.global_position
		$AudioStreamPlayer3D.stream = PUZZLE_SOLVED_JINGLE
		$AudioStreamPlayer3D.play()


func _on_buzzer_pressed() -> void:
	clear()
