extends Area3D

func _on_body_entered(body: Node3D) -> void:
	#print('Body entered: ', body)
	if body is CharacterBody3D:
		body.swimming = true
	


func _on_body_exited(body: Node3D) -> void:
	#print('Body exited: ', body)
	if body is CharacterBody3D:
		body.swimming = false
