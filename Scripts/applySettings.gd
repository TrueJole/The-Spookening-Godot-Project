extends Node3D

@onready var WEnvironment =  $WorldEnvironment.environment
@onready var bakedVoxelGI = $VoxelGI
@onready var volFog = $FogVolume
@onready var Settings = preload('res://Resources/globalSettings.tres')

# Called when the node enters the scene tree for the first time.
func _ready():
	
	WEnvironment.ssao_enabled = Settings.ssao
	volFog.visible = Settings.volumetricFog
	WEnvironment.ssil_enabled = Settings.ssil
	
	WEnvironment.sdfgi_enabled = false
	bakedVoxelGI.visible = Settings.GI == 'voxelGI'
	
	WEnvironment.sdfgi_enabled = Settings.GI == 'sdfgi'
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
