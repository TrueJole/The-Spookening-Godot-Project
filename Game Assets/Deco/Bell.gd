extends Node3D

@onready var audioStreamer: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _on_interactive_component_pressed() -> void:
	audioStreamer.play()
