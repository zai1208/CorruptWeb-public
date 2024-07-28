extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var loadBarFinished = false
var back_checked = false
var LoadingTextArray = ["Loading Assets", "Building Game", "Optimizing Game"]
var SetText = 0
var DotStage = 1

func _ready():
	OS.set_window_size(Vector2(500, 700))
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	OS.window_borderless = true
	get_tree().get_root().set_transparent_background(true)


func _on_Button_pressed():
	OS.set_window_size(Vector2(300, 500))
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)


func _on_Timer_timeout():
	#SceneManager.change_scene("main_menu")
	pass

func _on_LoadTimer_timeout():
	#$RadialProgressBar.progress += 2
	pass
func _physics_process(delta):
	if $RadialProgressBar.progress < 99.9:
		var random = RandomNumberGenerator.new()
		random.randomize()
		var nu = random.randf_range(0.0, 1.1)
		print(nu)
		$RadialProgressBar.progress += int(nu)
	else:
		if loadBarFinished == false:
			loadBarFinished = true
			$Timer4.start()
			
			
	#$Label/Label2.rect_position.x = 188
	#$Label/Label2.rect_position.y = 50
	$Label/Label2
func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.stop()
	SceneManager.change_scene("main_menu")


func _on_Timer2_timeout():
	if LoadAssets.loaded == true:
		back_checked = true


func _on_Timer3_timeout():
	if LoadAssets.loaded == true and back_checked == true:
		pass
	if SetText == 0:
		SetText += 1
	elif SetText == 1:
		SetText += 1
		

func _on_TextChangeTimer_timeout():
	if DotStage == 1:
		$Label/Label2.set_text(LoadingTextArray[SetText] + "")
		DotStage += 1
	elif DotStage == 2:
		$Label/Label2.set_text(LoadingTextArray[SetText] + ".")
		DotStage += 1
	elif DotStage == 3:
		$Label/Label2.set_text(LoadingTextArray[SetText] + "..")
		DotStage += 1
	elif DotStage == 4:
		$Label/Label2.set_text(LoadingTextArray[SetText] + "...")
		DotStage = 1


func _on_Timer4_timeout():
	$AudioStreamPlayer.play()
