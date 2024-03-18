extends Control

var Settings: Resource
@onready var subviewport = $PanelContainer/HBoxContainer/SubViewportContainer/SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	Settings = load('res://Resources/globalSettings.tres')
	get_node("PanelContainer/HBoxContainer/VBoxContainer/ssaoToggleButton").button_pressed = Settings.ssao
	get_node("PanelContainer/HBoxContainer/VBoxContainer/volFogToggleButton").button_pressed = Settings.volumetricFog
	get_node("PanelContainer/HBoxContainer/VBoxContainer/SSIL").button_pressed = Settings.ssil
	get_node("PanelContainer/HBoxContainer/VBoxContainer/giQualitySlider").value = Settings.giQuality
	get_node("PanelContainer/HBoxContainer/VBoxContainer/MSAAToggleButton").button_pressed = Settings.msaa
	_on_gi_quality_slider_value_changed(Settings.giQuality)
	

func applySettings():
	print_debug(Settings.volumetricFog)
	subviewport.get_node("WorldEnvironment").environment.ssao_enabled = Settings.ssao
	subviewport.get_node("FogVolume").visible = Settings.volumetricFog
	subviewport.get_node("WorldEnvironment").environment.ssil_enabled = Settings.ssil
	if Settings.msaa == true:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
	else:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
	
	
	
	ProjectSettings.set_setting('rendering/global_illumination/gi/use_half_resolution', false)
	RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_LOW)
	match Settings.giQuality:
		0:
			subviewport.get_node("VoxelGI").visible = false
		1:
			subviewport.get_node("VoxelGI").visible = true
			ProjectSettings.set_setting('rendering/global_illumination/gi/use_half_resolution', true)
		2:
			subviewport.get_node("VoxelGI").visible = true
		3:
			subviewport.get_node("VoxelGI").visible = true
			RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_HIGH)

func _on_back_button_pressed():
	ResourceSaver.save(Settings)
	hide()
	get_parent().get_node('MainMenu').show()
	


func _on_ssao_toggle_button_toggled(toggled_on):
	Settings.ssao = toggled_on
	applySettings()


func _on_vol_fog_toggle_button_toggled(toggled_on):
	Settings.volumetricFog = toggled_on
	applySettings()


# @deprecated
func _on_sdfgi_toggle_button_pressed():
	if Settings.GI == 'off':
		Settings.GI = 'voxelGI'
	elif Settings.GI == 'voxelGI':
		Settings.GI = 'sdfgi'
	elif Settings.GI == 'sdfgi':
		Settings.GI = 'off'
	else:
		Settings.GI = 'off'
	print_debug(Settings.GI)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/GIToggleButton").text = 'Global Illumination: ' + Settings.GI
	applySettings()

func _on_ssil_toggled(toggled_on):
	Settings.ssil = toggled_on
	applySettings()


func _on_gi_quality_slider_value_changed(value):
	Settings.giQuality = value
	match Settings.giQuality:
		0:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Aus'
		1:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Halbiert'
		2:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Voll'
		3:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Extra'
	applySettings()

func _on_msaa_toggle_button_toggled(toggled_on):
	Settings.msaa = toggled_on
	applySettings()

