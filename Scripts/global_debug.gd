extends Node

@export var info: Dictionary = {
	'fps': 0,
	'heldObject': null,
	'aim': null,
	#'cpuRenderTime': null,
	#'GPUms': null,
	'drawCalls': null,
	'memory': null,
}

@onready var label: Label = $/root/root/DebugInfo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Root.Settings.showFPS:
		info.fps = Engine.get_frames_per_second()
		#info.cpuMainRenderTime = RenderingServer.viewport_get_measured_render_time_cpu(get_viewport())
		info.memory = str(OS.get_static_memory_usage() / 1000000) + 'MB'
		info.drawCalls = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
		var temp: String = str(info)
		temp = temp.replace('{', '')
		temp = temp.replace('}', '')
		temp = temp.replace(',', '\n')
		label.text = temp
