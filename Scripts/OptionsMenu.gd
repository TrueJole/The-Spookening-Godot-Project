extends Control

@onready var subviewport: SubViewport = $PanelContainer/HBoxContainer/SubViewportContainer/SubViewport
# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	print(Root.Settings)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/ssaoToggleButton").button_pressed = Root.Settings.ssao
	get_node("PanelContainer/HBoxContainer/VBoxContainer/volFogToggleButton").button_pressed = Root.Settings.volumetricFog
	get_node("PanelContainer/HBoxContainer/VBoxContainer/SSIL").button_pressed = Root.Settings.ssil
	get_node("PanelContainer/HBoxContainer/VBoxContainer/SSRToggleButton").button_pressed = Root.Settings.ssr
	get_node("PanelContainer/HBoxContainer/VBoxContainer/giQualitySlider").value = Root.Settings.giQuality
	get_node("PanelContainer/HBoxContainer/VBoxContainer/MSAAToggleButton").button_pressed = Root.Settings.msaa
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessSlider").value = Root.Settings.exposure
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessLabel").text = 'Helligkeit: ' + str(Root.Settings.exposure).pad_decimals(2)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/shadowSlider").value = Root.Settings.shadowPower
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsToggleButton").button_pressed = Root.Settings.showFPS
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fullScreenToggleButton").button_pressed = Root.Settings.fullscreen
	get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsSlider").value = Root.Settings.fpsMode
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleSlider").value = Root.Settings.scale3D
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleLabel").text = "3D Skalierung: " + str(Root.Settings.scale3D*100) + "%"
	$PanelContainer/HBoxContainer/VBoxContainer/mouseSlider.value = Root.Settings.mousesens
	##$PanelContainer/HBoxContainer/VBoxContainer/hiResRainToggleButton.button_pressed = Root.Settings.hiResRain
	_on_gi_quality_slider_value_changed(Root.Settings.giQuality)
	_on_fps_slider_value_changed(Root.Settings.fpsMode)
	applySettings()

func applySettings() -> void:
	
	if Root.Settings.hiResRain:
		$"/root/root/SubViewport".size = Vector2(1920, 1920)
	else:
		$"/root/root/SubViewport".size = Vector2(720, 720)
	
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED, DisplayServer.get_window_list()[0])
	match Root.Settings.fpsMode:
		1:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = 'VSYNC'
			Engine.max_fps = 0
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED, DisplayServer.get_window_list()[0])
		2:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = '30 FPS'
			Engine.max_fps = 30
		3:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = '60 FPS'
			Engine.max_fps = 60
		4:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = '120 FPS'
			Engine.max_fps = 120
		5:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/fpsLabel").text = 'Unlimitierte FPS'
			Engine.max_fps = 0
	
	#print(Root.Settings.fpsMode)
	#print(Root.Settings.scale3D)
	subviewport.get_node("WorldEnvironment").environment.ssao_enabled = Root.Settings.ssao
	subviewport.get_node("WorldEnvironment").environment.volumetric_fog_enabled = Root.Settings.volumetricFog
	subviewport.get_node("WorldEnvironment").environment.ssil_enabled = Root.Settings.ssil
	subviewport.get_node("WorldEnvironment").environment.tonemap_exposure = Root.Settings.exposure
	subviewport.get_node("WorldEnvironment").environment.ssr_enabled = Root.Settings.ssr
	
	if Root.Settings.msaa == true:
		subviewport.msaa_3d = subviewport.MSAA_2X
	else:
		subviewport.msaa_3d = subviewport.MSAA_DISABLED
		"text"
		
	$PanelContainer/HBoxContainer/VBoxContainer/mouseLabel.text = 'Mausempfindlichkeit: ' + str(Root.Settings.mousesens * 1000)


	RenderingServer.directional_shadow_atlas_set_size(2**Root.Settings.shadowPower, true)
	subviewport.positional_shadow_atlas_size = 2**(Root.Settings.shadowPower-2)
	RenderingServer.gi_set_use_half_resolution(false)
	RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_LOW)
	subviewport.get_node("VoxelGI").subdiv = subviewport.get_node("VoxelGI").SUBDIV_64
	match Root.Settings.giQuality:
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
	
	get_tree().root.scaling_3d_scale = Root.Settings.scale3D
	subviewport.scaling_3d_scale = Root.Settings.scale3D
	var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.WRITE)
	file.store_var(Root.Settings, true) 


signal done
func _on_back_button_pressed() -> void:
	hide()
	done.emit()
	


func _on_ssao_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.ssao = toggled_on
	applySettings()


func _on_vol_fog_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.volumetricFog = toggled_on
	applySettings()


func _on_ssil_toggled(toggled_on: bool) -> void:
	Root.Settings.ssil = toggled_on
	applySettings()

func _on_gi_quality_slider_value_changed(value: int) -> void:
	Root.Settings.giQuality = value
	match Root.Settings.giQuality:
		0:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Aus'
		1:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Halbiert'
		2:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Voll'
		3:
			get_node("PanelContainer/HBoxContainer/VBoxContainer/GILabel").text = 'Extra'
	applySettings()

func _on_msaa_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.msaa = toggled_on
	applySettings()

func _on_brightness_slider_value_changed(value: float) -> void:
	Root.Settings.exposure = value
	get_node("PanelContainer/HBoxContainer/VBoxContainer/brightnessLabel").text = 'Helligkeit: ' + str(Root.Settings.exposure).pad_decimals(2)
	applySettings()

func _on_shadow_slider_value_changed(value: int) -> void:
	Root.Settings.shadowPower = value
	applySettings()


func _on_fps_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.showFPS = toggled_on
	applySettings()


func _on_full_screen_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.fullscreen = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_fps_slider_value_changed(value: int) -> void:
	#print_debug(value)
	Root.Settings.fpsMode = value
	
	applySettings()


func _on_scale_slider_value_changed(value: float) -> void:
	Root.Settings.scale3D = snappedf(value, 0.01)
	get_node("PanelContainer/HBoxContainer/VBoxContainer/scaleLabel").text = "3D Skalierung: " + str(Root.Settings.scale3D*100) + "%"
	applySettings()


func _on_ssr_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.ssr = toggled_on
	applySettings()


func _on_mouse_slider_value_changed(value: float) -> void:
	Root.Settings.mousesens = value
	applySettings()


func _on_hi_res_rain_toggle_button_toggled(toggled_on: bool) -> void:
	Root.Settings.hiResRain = toggled_on
	applySettings()
