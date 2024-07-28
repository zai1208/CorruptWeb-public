
extends Control





var is_LogoText_loading = true
var addition_rate = 0
var ChatCutscene = LoadAssets.get_asset("ChatCutsceneScene")
var LevelSelector = LoadAssets.get_asset("LevelSelectorScene")
var ModeSelector = LoadAssets.get_asset("ModeSelectorScene")
var SoundEnabled = false
var VsyncEnabled


func _ready():
	get_tree().get_root().set_transparent_background(false)
	OS.window_borderless = false
	$MainLogoText.percent_visible = 0 
	if MainMenuMusicSound.playing == false:
		MainMenuMusicSound.play()
		
	LoadSettings()
	VarCheck()
	
	OS.set_window_size(Vector2(1024, 600))
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	

func _process(delta):
	if is_LogoText_loading == true:
		$MainLogoText.percent_visible += addition_rate
		
	if $MainLogoText.percent_visible == 1:
		is_LogoText_loading = false
		
		
	if Engine.get_frames_per_second() > 1 and Engine.get_frames_per_second() < 5:
		addition_rate = 0.08
	elif Engine.get_frames_per_second() > 5 and Engine.get_frames_per_second() < 10:
		addition_rate = 0.016
	elif Engine.get_frames_per_second() > 10 and Engine.get_frames_per_second() < 20:
		addition_rate = 0.02
	elif Engine.get_frames_per_second() > 31:
		addition_rate = 0.006



func VarCheck():
	#Use this function for checks on Scene Load
	if SettingsManager.loaded == true:
		
		SoundEnabled = SettingsManager.getGameSaveKeyValue("SoundEnabled")
		VsyncEnabled = SettingsManager.getGameSaveKeyValue("VsyncEnabled")
		
		#Sound
		if not SoundEnabled == null: 
			if SoundEnabled == true:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
				$Settings/EnableSound/ToggleSound.pressed = true
			elif SoundEnabled == false:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
				$Settings/EnableSound/ToggleSound.pressed = false
		else:
			SettingsManager.addSetGameSave("SoundEnabled", true)
			$Settings/EnableSound/ToggleSound.pressed = true
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
			
			
		#Vsync
		if not VsyncEnabled == null:
			if VsyncEnabled == true:
				OS.vsync_enabled = true
				$Settings/VsyncSelection/ToggleVsync.pressed = true
			elif VsyncEnabled == false:
				OS.vsync_enabled = false
				$Settings/VsyncSelection/ToggleVsync.pressed = false
		else:
			SettingsManager.addSetGameSave("VsyncEnabled", true)
			$Settings/VsyncSelection/ToggleVsync.pressed = true
			OS.vsync_enabled = true
	else:
		#VarCheck() #Loops this function until Settings and Game Save are Loaded
		pass

func _on_PlayButton_pressed():
	if not SettingsManager.getGameSaveKeyValue("AlreadyPlayedChatCutScene") == null:
		if SettingsManager.getGameSaveKeyValue("AlreadyPlayedChatCutScene") == true:
			
			get_tree().change_scene_to(ModeSelector)
	else:
		SettingsManager.addSetGameSave("AlreadyPlayedChatCutScene", true)
		#MainMenuMusicSound.stop()
		get_tree().change_scene("res://Source/Scenes/GameCutscene.tscn")





func _on_DebugButton_pressed():
	$DebugSettings.popup()


func _on_CloseButton_pressed():
	$DebugSettings.hide()
	$Settings.hide()


func _on_ToggleShowFrameRate_pressed():
	if $DebugSettings/ShowFrameRate/ToggleShowFrameRate.pressed == true:
		SettingsManager.addDebugSetting("Debug_ShowFrameRateEnabled", true)
		Debugging.DebugFeature("FrameRate", "Enable")
	elif $DebugSettings/ShowFrameRate/ToggleShowFrameRate.pressed == false:
		SettingsManager.addDebugSetting("Debug_ShowFrameRateEnabled", false)
		Debugging.DebugFeature("FrameRate", "Disable")
		
func LoadSettings():
	if SettingsManager.loaded == true:
		var b = SettingsManager.GameSave
		#{"Settings": {"Debug" : {} }, "GameSave" : {}}
		if "Debug_ShowFrameRateEnabled" in b["Settings"]["Debug"]:
			if b["Settings"]["Debug"]["Debug_ShowFrameRateEnabled"] == true:
				$DebugSettings/ShowFrameRate/ToggleShowFrameRate.pressed = true
				Debugging.DebugFeature("FrameRate", "Enable")
			else:
				Debugging.DebugFeature("FrameRate", "Disable")


func _on_OpenProjectDataFolder_pressed():
	var p = OS.get_user_data_dir()
	var t = p + "/CorruptWeb"
	OS.shell_open(str("file://", t))


func _on_SettingsButton_pressed():
	$Settings.popup()


func _on_ToggleSound_pressed():
	#Fixed Sound Setting
	if $Settings/EnableSound/ToggleSound.pressed == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		print("Sound On")
		SettingsManager.addSetGameSave("SoundEnabled", true)
	elif $Settings/EnableSound/ToggleSound.pressed == false:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		print("Sound Off")
		SettingsManager.addSetGameSave("SoundEnabled", false)
		


func _on_PlayButton_mouse_entered():
	$MouseHoverSound.play()


func _on_SettingsButton_mouse_entered():
	$MouseHoverSound.play()
	
	
	
	


func _on_MouseHoverSound_finished():
	print("Sound Stopping")
	$MouseHoverSound.stop()


func _on_ToggleVsync_pressed():
	if $Settings/VsyncSelection/ToggleVsync.pressed == true:
		OS.vsync_enabled = true
		SettingsManager.addSetGameSave("VsyncEnabled", true)
	elif $Settings/VsyncSelection/ToggleVsync.pressed == false:
		OS.vsync_enabled = false
		SettingsManager.addSetGameSave("VsyncEnabled", false)


func _on_ToggleVsync_mouse_entered():
	$Settings/SettingInfoLabel.set_text("Recomended Setting, Vsync synchronizes the refresh rate to the frame rate of your monitor")


func _on_ToggleVsync_mouse_exited():
	$Settings/SettingInfoLabel.set_text("")


func _on_SettingVsyncInfo_mouse_entered():
	$Settings/SettingInfoLabel.set_text("Recomended Setting, Vsync synchronizes the refresh rate to the frame rate of your monitor")


func _on_SettingVsyncInfo_mouse_exited():
	$Settings/SettingInfoLabel.set_text("")


func _on_SettingSoundInfo_mouse_entered():
	$Settings/SettingInfoLabel.set_text("Mute/Un-mute sound from the game")

func _on_SettingSoundInfo_mouse_exited():
	$Settings/SettingInfoLabel.set_text("")

