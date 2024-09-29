extends StaticBody3D

@export var lit: bool 
@export var changeable: bool
@onready var omni_light_3d: OmniLight3D = $OmniLight3D
@onready var interactive_component: Area3D = $"Interactive Component"

var justLit: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	omni_light_3d.visible = lit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#print(justLit)
	justLit -= 1
	omni_light_3d.visible = lit
	interactive_component.visible = changeable


func _on_interactive_component_pressed() -> void:
	if changeable:
		if justLit < 0:
			lit = not lit
			omni_light_3d.visible = lit
		justLit = 3

	
	
	
