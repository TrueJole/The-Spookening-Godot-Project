extends Control

var Settings: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	Settings = preload('res://Resources/globalSettings.tres')
	get_node("VBoxContainer/ssaoToggleButton").button_pressed = Settings.ssao
	get_node("VBoxContainer/volFogToggleButton").button_pressed = Settings.volumetricFog
	get_node("VBoxContainer/SSIL").button_pressed = Settings.ssil
	get_node("VBoxContainer/giQualitySlider").value = Settings.giQuality
	_on_gi_quality_slider_value_changed(Settings.giQuality)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	ResourceSaver.save(Settings)
	hide()
	get_parent().get_node('MainMenu').show()
	


func _on_ssao_toggle_button_toggled(toggled_on):
	Settings.ssao = toggled_on


func _on_vol_fog_toggle_button_toggled(toggled_on):
	Settings.volumetricFog = toggled_on


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
	get_node("VBoxContainer/GIToggleButton").text = 'Global Illumination: ' + Settings.GI


func _on_ssil_toggled(toggled_on):
	Settings.ssil = toggled_on


func _on_gi_quality_slider_value_changed(value):
	Settings.giQuality = value
	match Settings.giQuality:
		0:
			get_node("VBoxContainer/GILabel").text = 'Aus'
		1:
			get_node("VBoxContainer/GILabel").text = 'Halbiert'
		2:
			get_node("VBoxContainer/GILabel").text = 'Voll'
		3:
			get_node("VBoxContainer/GILabel").text = 'Extra'
