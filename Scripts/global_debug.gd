extends Node

@export var info: Dictionary = {
	'heldObject': null,
	'aim': null,
	'fps': 0,
	'minfps': 0,
	'physic_process_time': 0,
	#'cpuRenderTime': null,
	#'GPUms': null,
	'drawCalls': 0,
	'objectsDrawn': 0,
	'memory': 0,
	'videoMemory': 0
}

var fpsArray: Array[float]
@onready var label: Label = $/root/root/DebugInfo
var timer: Timer
func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.connect('timeout', calcMinFPS)
	timer.start(5)
	
func calcMinFPS() -> void:
	#var n: int = round(fpsArray.size() / 100.0)
	
	#info.minfps = min(fpsArray)
	fpsArray.clear()
	timer.start(5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Root.Settings.showFPS:
		info.fps = Engine.get_frames_per_second()
		fpsArray.append(round(1.0 / Performance.get_monitor(Performance.TIME_PROCESS)))
		info.minfps = fpsArray.min()
		info.physic_process_time = str(Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000) + 'ms'
		#info.cpuMainRenderTime = RenderingServer.viewport_get_measured_render_time_cpu(get_viewport())
		info.memory = str(OS.get_static_memory_usage() / 1000000) + 'MB'
		info.drawCalls = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
		info.objectsDrawn = Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)
		info.videoMemory = str(round(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / 1000000)) + 'MB'
		
		var temp: String = str(info)
		temp = temp.replace('{', '')
		temp = temp.replace('}', '')
		temp = temp.replace('"', '')
		temp = temp.replace(',', '\n')
		label.text = temp
