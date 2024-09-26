extends Tür

@onready var activator: Area3D = $"Activation Module"


func _on_activation_module_activated(body: Node3D) -> void:
	locked = false
	emit_signal("opened")
	print_debug('recieved')

func _physics_process(_delta: float) -> void:
	basicDoorFunc()
