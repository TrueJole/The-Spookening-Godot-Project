extends StaticBody3D
class_name LaserReceiver

const GREEN_LIGHT: StandardMaterial3D = preload("res://Assets/Materials/GreenLightOn.tres")
const RED_LIGHT: StandardMaterial3D = preload("res://Assets/Materials/RedLightOff.tres")

var receiving: bool = false
var activated: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(activated)
	if not receiving:
		activated = false
		$Timer.stop()
		$Cylinder.set_surface_override_material(1, RED_LIGHT)
	if receiving:
		receiving = false
	
	
	
func laser_activated() -> void:
	#print('laser')
	if not receiving:
		#print(activated)
		$Cylinder.set_surface_override_material(1, GREEN_LIGHT)
		if $Timer.is_stopped():
			$Timer.start()
		receiving = true
	

func _on_timer_timeout() -> void:
	activated = true
