extends Node

@export var rain: SubViewport = SubViewport.new()
@export var rainTexture: ViewportTexture = ViewportTexture.new()
@export var Settings: Resource = SettingsClass.new()


func _ready() -> void:
	rain = get_node("/root/root/SubViewport")
	rainTexture = rain.get_texture()
	print('Rain: ', rain)

func on_scene_loaded() -> void:
	pass

func default_settings() -> void:
	print('applied default settings')
	Settings.ssao = true
	Settings.volumetricFog = true
	Settings.ssr = true
	Settings.ssil = false
	Settings.giQuality = 1
	Settings.msaa = true
	Settings.exposure = 1
	Settings.shadowPower = 12
	Settings.showFPS = false
	Settings.fullscreen = true
	Settings.fpsMode = 1
	Settings.scale3D = 1
	Settings.mousesens = 0.002

func _init() -> void:
	#DirAccess.remove_absolute('user://settings.tres')
	#default_settings()
	#var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.WRITE)
	#file.store_var(Settings, true)


	#file.close()
	if FileAccess.file_exists('user://settings.dat'):
		var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.READ_WRITE)
		
		Settings = file.get_var(true)
		print(Settings)
		print('Loaded Settings')
	else:
		default_settings()
		
		
		
	#else:
	#	file.store_var(Settings)
	#file.close()
