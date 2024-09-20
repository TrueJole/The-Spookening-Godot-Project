extends Node3D

@onready var WEnvironment:Resource =  $WorldEnvironment.environment
@onready var bakedVoxelGI: VoxelGI = $VoxelGI
@onready var volFog: FogVolume = $FogVolume
#@onready var Settings: GlobalSettings = preload('res://Resources/globalSettings.tres')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	WEnvironment.ssao_enabled = Root.Settings.ssao
	#volFog.visible = Settings.volumetricFog
	WEnvironment.ssil_enabled = Root.Settings.ssil
	WEnvironment.tonemap_exposure = Root.Settings.exposure
	
	#WEnvironment.sdfgi_enabled = false
	#bakedVoxelGI.visible = (Settings.GI == 'voxelGI')
	#WEnvironment.sdfgi_enabled = (Settings.GI == 'sdfgi')
	#FIXME Einstellung wird nicht geändert
	
	
	if Root.Settings.msaa == true:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
	else:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
	
	RenderingServer.directional_shadow_atlas_set_size(2**Root.Settings.shadowPower, true)
	get_viewport().positional_shadow_atlas_size = 2**(Root.Settings.shadowPower-2)
	RenderingServer.gi_set_use_half_resolution(false)
	RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_LOW)
	bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_64
	match Root.Settings.giQuality:
		0:
			bakedVoxelGI.visible = false
		1:
			bakedVoxelGI.visible = true
			RenderingServer.gi_set_use_half_resolution(true)
		2:
			bakedVoxelGI.visible = true
			bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_128
		3:
			bakedVoxelGI.visible = true
			bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_256
			RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_HIGH)
	
	get_tree().root.scaling_3d_scale = Root.Settings.scale3D
	
	# ENABLE WIREFRAME MODE
	#get_tree().root.debug_draw = 4
	
