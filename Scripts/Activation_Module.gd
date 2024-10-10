extends Area3D

signal activated(body: Node3D)

@export var all_item_ids: bool
@export var activators:Array[String]
var lastBody: Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#print_debug(activated.is_connected(get_parent().activated()))
	if has_overlapping_bodies():
		for body: Node3D in get_overlapping_bodies():
			
			if body.has_meta('itemid'):
				#print_debug(body.get_meta('itemid'))
				if all_item_ids or body.get_meta('itemid') in activators:
					#print_debug(body)
					lastBody = body
					if body.has_method('activated'):
						body.activated(self)
					if get_parent().has_method('activated'):
						get_parent().activated()
					activated.emit(body)
	if has_overlapping_areas():
		for area: Area3D in get_overlapping_areas():
			if area.has_meta('itemid'):
				if area.get_meta('itemid') in activators:
					#print_debug(body)
					if get_parent().has_method('activated'):
						get_parent().activated()
					activated.emit(area)
					
