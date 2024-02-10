extends Node3D

@onready var WEnvironment =  $WorldEnvironment.environment
@onready var bakedVoxelGI = $VoxelGI
@onready var Settings = preload('res://globalSettings.tres')

# Called when the node enters the scene tree for the first time.
func _ready():
	
	WEnvironment.ssao_enabled = Settings.ssao
	WEnvironment.volumetric_fog_enabled = Settings.volumetricFog
	WEnvironment.ssil_enabled = Settings.ssil
	
	WEnvironment.sdfgi_enabled = false
	bakedVoxelGI.hide()
	if Settings.GI == 'voxelGI':
		bakedVoxelGI.show()
	elif Settings.GI == 'sdfgi':
		WEnvironment.sdfgi_enabled = true
		print_debug('sdfgi: ',WEnvironment.sdfgi_enabled)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
