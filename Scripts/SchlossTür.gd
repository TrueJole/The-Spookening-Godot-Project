extends Tür

@onready var activator: Area3D = $"Activation Module"
@onready var schloss: Node3D = $Schloss


func basicDoorFunc() -> void:
	super()

signal opened
func _on_activation_module_activated(_body: Node3D) -> void:
	locked = false
	schloss.hide()
	opened.emit()
	var tween1: Tween = create_tween()
	var tween2: Tween = create_tween()
	tween1.tween_property(_body, "global_position",$"Activation Module".global_position, 0.4)
	tween2.tween_property(_body, "rotation",$"Activation Module".rotation, 0.4)
	
	#print_debug('recieved')

func _physics_process(_delta: float) -> void:
	basicDoorFunc()


func _on_activation_module_2_activated2(_body: Node3D) -> void:
	locked = false
	schloss.hide()
	opened.emit()
	var tween1: Tween = create_tween()
	var tween2: Tween = create_tween()
	tween1.tween_property(_body, "global_position",$"Activation Module2".global_position, 0.4)
	tween2.tween_property(_body, "rotation",$"Activation Module2".rotation, 0.4)
