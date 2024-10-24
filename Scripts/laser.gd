extends Node3D
const MAX_LENGTH: int = 1000
const LIMIT: int = 10
const LIGHT_LIMIT: int = 5
var laserCount: int

const LASERLIGHT: PackedScene = preload("res://Game Assets/Parts/laserlight.tscn")

func laser(startpoint: Vector3, direction: Vector3) -> void:
	laserCount += 1
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(startpoint,startpoint + (direction * MAX_LENGTH))
	query.exclude = [get_node('/root/root/World/Player')] 
	var result: Dictionary = space_state.intersect_ray(query)
	
	if result:
		#print(result.collider)
		DebugDraw3D.draw_line(startpoint, result.position, Color(1, 0, 0))
		if result.collider.has_method('laser_activated'):
			result.collider.laser_activated()
		
		var light: OmniLight3D
		if laserCount < LIGHT_LIMIT:
			#print('licht')
			light = LASERLIGHT.instantiate()
			add_child(light)
			light.global_position = result.position - direction * 0.1
		
		if result.collider.has_meta('mirror') and result.collider.get_meta('mirror') == true and laserCount < LIMIT: 
			laser(result.position - direction * 0.05, direction.bounce(result.normal))
		
		await get_tree().process_frame
		if light:
			light.queue_free()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	laserCount = 0
	laser(global_position, get_global_transform().basis.x)
	
