extends Tür

@onready var lasers: Node = $Lasers

func _process(delta: float) -> void:
	if locked:
		lasers.show()
	else:
		lasers.hide()

func _physics_process(delta: float) -> void:
	basicDoorFunc()
