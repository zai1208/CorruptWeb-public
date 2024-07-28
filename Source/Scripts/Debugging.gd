extends Node




onready var Features = {"FPSCountEnabled" : false}
onready var fps
func _ready():
	pass 




func DebugFeature(feature, e):
	if feature == "FrameRate":
		if e == "Enable":
			OS.set_window_title("CorruptWeb | FPS: " + str(fps))
			Features["FPSCountEnabled"] = true
		if e == "Disable":
			OS.set_window_title("CorruptWeb")
			Features["FPSCountEnabled"] = false
			
func _physics_process(delta):
	fps = Engine.get_frames_per_second()
	if Features["FPSCountEnabled"] == true:
		OS.set_window_title("CorruptWeb | FPS: " + str(fps))
	else:
		OS.set_window_title("CorruptWeb")
