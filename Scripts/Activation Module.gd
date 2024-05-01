extends Area3D

signal activated

@export var activators:Array[String]
var lastBody


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#print_debug(activated.is_connected(get_parent().activated()))
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			
			if body.has_meta('itemid'):
				#print_debug(body.get_meta('itemid'))
				if body.get_meta('itemid') in activators:
					#print_debug(body)
					lastBody = body
					if body.has_method('activated'):
						body.activated()
					if get_parent().has_method('activated'):
						get_parent().activated()
					activated.emit()
	if has_overlapping_areas():
		for area in get_overlapping_areas():
			if area.has_meta('itemid'):
				if area.get_meta('itemid') in activators:
					#print_debug(body)
					if get_parent().has_method('activated'):
						get_parent().activated()
					activated.emit()
					

