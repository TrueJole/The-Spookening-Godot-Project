@tool
extends Window
class_name MultiMeshConverterWindow

var inspector_plugin:EditorInspectorPlugin
var selections:Array[bool] = []

func _ready() -> void:
	if !Engine.is_editor_hint():
		%ElementSample.hide()
	var new_stylebox:StyleBoxFlat = StyleBoxFlat.new()
	new_stylebox.bg_color = get_theme_color("base_color", "Editor")
	$PanelCon.add_theme_stylebox_override("panel", new_stylebox)
	%Finished.set_deferred("disabled", true)
	%CombinableMessage.show()
	get_child(0).theme = ThemeDB.get_default_theme()
	%Finished.pressed.connect(func():
		print_rich("[color=white]Adding optimized MultiMeshInstance3Ds...[/color]")
		for element in %Elements.get_children():
			element.add_multimeshes()
		print_rich("\t[color=green]Done![/color]")
		close_requested.emit()
		)
	%Cancel.pressed.connect(func():
		close_requested.emit())
	close_requested.connect(func():
		queue_free())

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and event.is_pressed():
		close_requested.emit()




func set_mesh_collections(mesh_collections:Array[Array]):
	if mesh_collections.size() != 0:
		%Finished.disabled = false
		%CombinableMessage.hide()
	else:
		return
	for element in %Elements.get_children():
		element.queue_free()
	for collection:Array in mesh_collections:
		for similars:Array in collection:
			selections.append(false)
			var new_element:Control = %ElementSample.duplicate()
			new_element.show()
			new_element.get_node("HBoxContainer/ViewportCon/SubViewport").world_3d = World3D.new()
			%Elements.add_child(new_element)
			new_element.get_node("HBoxContainer/VBoxContainer/Combine").toggled.connect(func(toggled:bool):
				selections[new_element.get_index()] = toggled
				var all_negative:bool = true
				for i in selections:
					if i == true:
						all_negative = false
						break
				%Finished.disabled = all_negative
					
				)
			new_element.set_mesh_instances(similars)
