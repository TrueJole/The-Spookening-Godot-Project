extends StaticBody3D

@onready var sphere: MeshInstance3D = $Sphere
@export var activated: bool
@onready var magic_text: Label3D = $MagicText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activated:
		var temp: Material = sphere.get_surface_override_material(0)
		temp.albedo_color.a = 0.1
		sphere.set_surface_override_material(0, temp)
		magic_text.show()
