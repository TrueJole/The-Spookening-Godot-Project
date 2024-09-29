extends Tür

@onready var activator: Area3D = $"Activation Module"
@onready var schloss: Node3D = $Schloss


func basicDoorFunc() -> void:
	super()

signal opened
func _on_activation_module_activated(_body: Node3D) -> void:
	locked = false
	schloss.hide()
	emit_signal("opened")
	print_debug('recieved')

func _physics_process(_delta: float) -> void:
	basicDoorFunc()
