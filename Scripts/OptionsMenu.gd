extends Control

var Settings: Resource
@onready var subviewport := $PanelContainer/HBoxContainer/SubViewportContainer/SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Settings = load('res://Resources/globalSettings.tres')
	#Settings.resolutionX = 1920
	get_node("PanelContainer/HBoxContainer/VBoxContainer/ssaoToggleButton").button_pressed = Settings.ssao
	get_node("PanelContainer/HBoxContainer/VBoxContainer/volFogToggleButton").button_pressed = Settings.volumetricFog
	get_node("PanelContainer/HBoxContainer/VBoxContainer/SSIL").button_pressed = Settings.ssil
	get_node("PanelContainer/HBoxContainer/VBoxContainer/giQualitySlider").value = Settings.giQuality
	get_node("PanelContainer/HBoxContainer/VBoxContainer/MSAAToggleButton").button_pressed = Settings.msaa
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessSlider").value = Settings.exposure
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessLabel").text = 'Helligkeit: ' + str(Settings.exposure).pad_decimals(2)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/shadowSlider").value = Settings.shadowPower
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsToggleButton").button_pressed = Settings.showFPS
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fullScreenToggleButton").button_pressed = Settings.fullscreen
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsSlider").value = Settings.fpsMode
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleSlider").value = Settings.scale3D
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleLabel").text = "3D Skalierung: " + str(Settings.scale3D*100) + "%"
	_on_gi_quality_slider_value_changed(Settings.giQuality)
	_on_fps_slider_value_changed(Settings.fpsMode)
	applySettings()

func applySettings():
	_on_fps_slider_value_changed(Settings.fpsMode)
	#print_debug(2**Settings.shadowPower)
	subviewport.get_node("WorldEnvironment").environment.ssao_enabled = Settings.ssao
	subviewport.get_node("FogVolume").visible = Settings.volumetricFog
	subviewport.get_node("WorldEnvironment").environment.ssil_enabled = Settings.ssil
	subviewport.get_node("WorldEnvironment").environment.tonemap_exposure = Settings.exposure
	
	if Settings.msaa == true:
		subviewport.msaa_3d = subviewport.MSAA_2X
	else:
		subviewport.msaa_3d = subviewport.MSAA_DISABLED

	RenderingServer.directional_shadow_atlas_set_size(2**Settings.shadowPower, true)
	subviewport.positional_shadow_atlas_size = 2**(Settings.shadowPower-2)
	RenderingServer.gi_set_use_half_resolution(false)
	RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_LOW)
	subviewport.get_node("VoxelGI").subdiv = subviewport.get_node("VoxelGI").SUBDIV_64
	match Settings.giQuality:
		0:
			subviewport.get_node("VoxelGI").visible = false
		1:
			subviewport.get_node("VoxelGI").visible = true
			RenderingServer.gi_set_use_half_resolution(true)
		2:
			subviewport.get_node("VoxelGI").visible = true
			subviewport.get_node("VoxelGI").subdiv = subviewport.get_node("VoxelGI").SUBDIV_128
		3:
			subviewport.get_node("VoxelGI").visible = true
			RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_HIGH)
			subviewport.get_node("VoxelGI").subdiv = subviewport.get_node("VoxelGI").SUBDIV_256
	
	get_tree().root.scaling_3d_scale = Settings.scale3D
	subviewport.scaling_3d_scale = Settings.scale3D
	#print_debug(get_tree().root.scaling_3d_scale)

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

func _on_brightness_slider_value_changed(value):
	Settings.exposure = value
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessLabel").text = 'Helligkeit: ' + str(Settings.exposure).pad_decimals(2)
	applySettings()

func _on_shadow_slider_value_changed(value):
	Settings.shadowPower = value
	applySettings()


func _on_fps_toggle_button_toggled(toggled_on):
	Settings.showFPS = toggled_on


func _on_full_screen_toggle_button_toggled(toggled_on):
	Settings.fullscreen = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_fps_slider_value_changed(value):
	#print_debug(value)
	Settings.fpsMode = value
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED, DisplayServer.get_window_list()[0])
	match Settings.fpsMode:
		1:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = 'VSYNC'
			Engine.max_fps = 0
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED, DisplayServer.get_window_list()[0])
		2:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = '30 FPS'
			Engine.max_fps = 30
		3:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").texWorldt = '60 FPS'
			Engine.max_fps = 60
		4:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = '120 FPS'
			Engine.max_fps = 120
		5:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = 'Unlimitierte FPS'
			Engine.max_fps = 0
	






func _on_scale_slider_value_changed(value):
	Settings.scale3D = snappedf(value, 0.01)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleLabel").text = "3D Skalierung: " + str(Settings.scale3D*100) + "%"
	applySettings()
