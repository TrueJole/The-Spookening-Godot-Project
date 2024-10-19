@tool
extends MarginContainer

@onready var combine: CheckButton = $HBoxContainer/VBoxContainer/Combine
@onready var mesh_instance:MeshInstance3D = $HBoxContainer/ViewportCon/SubViewport/Node3D/MeshInstance
@onready var action_explanation: Label = $HBoxContainer/VBoxContainer/ActionExplanation
@onready var amount_label: Label = $HBoxContainer/VBoxContainer2/Amount

@onready var keep_collisions: CheckButton = $HBoxContainer/VBoxContainer/KeepCollisions
@onready var parent_texture: TextureRect = $HBoxContainer/VBoxContainer2/Info/VBoxContainer/HBoxContainer/ParentTexture
@onready var parent_node: Label = $HBoxContainer/VBoxContainer2/Info/VBoxContainer/HBoxContainer/ParentNode



const SEPERATE_MESSAGE:String = "Keep Meshes seperate"
const COMBINE_MESSAGE:String = "Combine Meshes into Multimesh"

const NO_COMBINATIONS_MESSAGE:String = "No meshes selected"

var has_collisions:bool = false

var instances:Array[MeshInstance3D] = []

func _ready() -> void:
	
	combine.toggled.connect(func(toggled:bool):
		if toggled:
			action_explanation.text = COMBINE_MESSAGE
		else:
			action_explanation.text = SEPERATE_MESSAGE)
	action_explanation.text = SEPERATE_MESSAGE


func set_mesh_instances(mesh_instances:Array[MeshInstance3D]) -> void:
	for i in mesh_instances:
		if i.get_child_count() > 0 and i.get_child(0) is StaticBody3D:
			has_collisions = true
			break
	if !has_collisions:
		keep_collisions.set_deferred("disabled", true)
	var parent_class:String = mesh_instances[0].get_parent().get_class()
	parent_texture.texture = get_theme_icon(parent_class, "EditorIcons")
	parent_node.text = mesh_instances[0].get_parent().name
	instances = mesh_instances
	mesh_instance.mesh = mesh_instances[0].mesh
	amount_label.text = "Amount: " + str(mesh_instances.size())
	

func add_multimeshes(mesh_instances = instances) -> void:
	if !combine.button_pressed:
		print_rich("\t[color=darkgreen]Marked as seperate. Will not combine...[/color]")
		return
	if mesh_instances == []:
		print_rich("\t[color=orange]Found no meshes. Skipping this mesh...[/color]")
		return
	var multimesh:MultiMesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = mesh_instances.size()
	multimesh.mesh = mesh_instances[0].mesh
	for i in mesh_instances.size():
		var transform:Transform3D = Transform3D(mesh_instances[i].transform)
		multimesh.set_instance_transform(i, transform)
	var multimesh_instance:MultiMeshInstance3D = MultiMeshInstance3D.new()
	multimesh_instance.multimesh = multimesh
	var parent:Node = mesh_instances[0].get_parent()
	var collisions:Array[CollisionShape3D] = []
	if keep_collisions.button_pressed:
		print_rich("\t[color=cyan]Keeping Collisions:[/color]")
		var physics_material:PhysicsMaterial
		for i in mesh_instances:
			if i.get_child_count() > 0 and i.get_child(0) is StaticBody3D:
				print_rich("\t[color=green]", i.name, " has StaticBody3D as a child. Adding collision to MultiMesh...[/color]")
				for collision_object in i.get_child(0).get_children():
					#print_rich("\n\n[color=white]Iterating over child: ", collision_object, "...[/color]")
					if collision_object is CollisionShape3D:
						physics_material = i.get_child(0).physics_material_override
						var pos:Vector3 = collision_object.global_position
						collisions.append(collision_object)
					else:
						print_rich("\t\t[color=yellow]Child of StaticBody3D was not CollisionShape3D. Continuing...[/color]")
						
			else:
				print_rich("\t[color=yellow]", i.name, " didn't have StaticBody as child. Skipping collision...[/color]")
		if collisions.size() > 0:
			var body:StaticBody3D = StaticBody3D.new()
			if physics_material:
				body.physics_material_override = physics_material
			multimesh_instance.add_child(body, true)
			for col in collisions:
				var duplicat:CollisionShape3D = col.duplicate()
				body.add_child(duplicat)
				#duplicat.global_position = col.global_position
				duplicat.global_transform = col.global_transform
			
	multimesh_instance.name = mesh_instances[0].name
	parent.add_child(multimesh_instance, true)
	multimesh_instance.set_owner(get_tree().edited_scene_root)
	if multimesh_instance.get_child_count() == 1:
		#multimesh_instance.get_child(0).global_transform = multimesh_instance.get_parent_node_3d().global_transform
		multimesh_instance.get_child(0).global_position -= (multimesh_instance.global_position)
		multimesh_instance.get_child(0).global_rotation -= multimesh_instance.get_parent_node_3d().global_rotation
		multimesh_instance.get_child(0).scale = Vector3.ONE / multimesh_instance.get_parent_node_3d().scale
		multimesh_instance.get_child(0).set_owner(get_tree().edited_scene_root)
		for child:CollisionShape3D in multimesh_instance.get_child(0).get_children():
			child.set_owner(get_tree().edited_scene_root)
			#child.global_position -= multimesh_instance.get_parent().global_position
		
	print_rich("\t[color=cyan]Added MultiMeshInstance3D to replace ", mesh_instances.size(), " MeshInstance3Ds...")
	
