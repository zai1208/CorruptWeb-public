extends CanvasLayer







var SoundEnabled = true
var main_menu = LoadAssets.get_asset("MainMenu")
var mode_selection = LoadAssets.get_asset("ModeSelectorScene")
var IgnoredNodes = ["AnimationPlayer", "SettingsTimer", "SettingsPopup"]
func _ready():
	set_visibility(false)
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




func set_visibility(vis):
	for n in get_children():
		if not n.name in IgnoredNodes: 
			n.visible = vis 


func _on_ResumeGame_pressed():
	get_tree().paused = false
	set_visibility(false)


func _on_Settings_pressed():
	$SettingsPopup.show()


func _on_ExitTutorial_pressed():
	get_tree().change_scene("res://Source/Scenes/ModeSelection.tscn")
	get_tree().paused = false

func _on_QuitToMainMenu_pressed():
	set_visibility(false)
	get_tree().change_scene("res://Source/Scenes/ModeSelection.tscn")
	get_tree().paused = false

func _on_QuitToDesktop_pressed():
	GameExit.CheckAndQuit()


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


func _on_ClosePopup_pressed():
	$SettingsPopup.hide()
	
	
	
func _input(event):
	if event.is_action_pressed("Escape"):
		if get_tree().paused == false:
			set_visibility(true)
			get_tree().paused = true
		elif get_tree().paused == true:
			set_visibility(false)
			get_tree().paused = false
