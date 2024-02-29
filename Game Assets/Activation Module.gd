extends Area3D

signal activated

@export var activators:Array[String]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print_debug(activated.is_connected(get_parent().activated()))
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body.has_meta('itemid'):
				if body.get_meta('itemid') in activators:
					#print_debug(body)
					if get_parent().has_method('activated'):
						get_parent().activated()
					activated.emit()
					

