extends CanvasLayer



var main_menu = LoadAssets.get_asset("MainMenu")

var SoundEnabled = true
var IgnoredNodes = ["AnimationPlayer", "SettingsTimer", "SettingsPopup"]
func _ready():
	Global.Playing = true
	set_amountNodesVisibility(false)
	#get_tree().paused(false)
	SoundEnabled = SettingsManager.getGameSaveKeyValue("SoundEnabled")
		
		#Sound
	if not SoundEnabled == null: 
		if SoundEnabled == true:
			
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
			
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
			
		elif SoundEnabled == false:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = false
	else:
		SettingsManager.addSetGameSave("SoundEnabled", true)
		$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	
func _input(event):
	if event.is_action_pressed("Escape") and Global.Playing == true:                      
		print("Escape pressed")
		if get_tree().paused == false:
			$AnimationPlayer.play("FadeInPause")
			set_amountNodesVisibility(true)
			get_tree().paused = true 
			print("Set to true")
			
			
		elif get_tree().paused == true: 
			$AnimationPlayer.play_backwards("FadeInPause")
			set_amountNodesVisibility(false)
			get_tree().paused = false
			print("Set to false")
			
		
		
		
		
		
func set_amountNodesVisibility(vis):
		for i in get_children():
			if not i.name in IgnoredNodes:
				i.visible = vis


func _on_ResumeGame_pressed():
	Engine.time_scale = 1
	set_amountNodesVisibility(false)
	get_tree().paused = false
	

func _on_Settings_pressed():
	$SettingsPopup.show()


func _on_QuitToMainMenu_pressed():
	set_amountNodesVisibility(false)
	get_tree().paused = false
	get_tree().change_scene_to(main_menu) #Main Menu is a stored scene


func _on_QuitToDesktop_pressed():
	GameExit.CheckAndQuit()


func _on_ClosePopup_pressed():
	$SettingsPopup.hide()


func _on_CheckButton_pressed():
	if $SettingsPopup/ColorRect/Control/CheckButton.pressed == true:
		SoundEnabled = true
		
	elif $SettingsPopup/ColorRect/Control/CheckButton.pressed == false:
		SoundEnabled = false
	
	
	if not SoundEnabled == null: 
		if SoundEnabled == true:
			
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
			
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
			
		elif SoundEnabled == false:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = false
	else:
		SettingsManager.addSetGameSave("SoundEnabled", true)
		$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		

func _on_SettingsTimer_timeout():
	
	SoundEnabled = SettingsManager.getGameSaveKeyValue("SoundEnabled")
		
		#Sound
	if not SoundEnabled == null: 
		if SoundEnabled == true:
			
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
			
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
			
		elif SoundEnabled == false:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
			$SettingsPopup/ColorRect/Control/CheckButton.pressed = false
	else:
		SettingsManager.addSetGameSave("SoundEnabled", true)
		$SettingsPopup/ColorRect/Control/CheckButton.pressed = true
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
