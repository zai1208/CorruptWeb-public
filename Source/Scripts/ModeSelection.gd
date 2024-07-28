extends Control


#Default Keyboard Selection Position:  X: 77, Y: 165

var MainMenuScene = LoadAssets.get_asset("MainMenu")
var OnMode
func _ready():
	$AnimationPlayer.play("AnimationReset")
	$FadeInAnimation.play("FadeInModeSelection")



func _input(event):
	if event.is_action_pressed("LeftMouseClick"):
		if not OnMode == null:
			if OnMode == "Recovery":
				LevelGenerationData.GAME_MODE = 2
			elif OnMode == "Corrupted":
				LevelGenerationData.GAME_MODE = 1
				
			get_tree().change_scene("res://Source/Scenes/LevelSelector.tscn")

func _on_RecoveryMouseDetection_mouse_entered():
	$AnimationPlayer2.play("ScenesRecoveryModeMouseOver")
	$ModeDescriptionLabel.set_text("Collect data and recover a continent with the data collected")
	$AudioStreamPlayer.play()
	OnMode = "Recovery"
	
func _on_RecoveryMouseDetection_mouse_exited():
	$AnimationPlayer2.play_backwards("ScenesRecoveryModeMouseOver")
	$ModeDescriptionLabel.set_text("")
	OnMode = null
	
func _on_CorruptModeMouseOver_mouse_entered():
	$AnimationPlayer.play("CorruptModeMouseOver")
	$ModeDescriptionLabel.set_text("Repair computers corrupted by the worm")
	$AudioStreamPlayer.play()
	OnMode = "Corrupted"
	
func _on_CorruptModeMouseOver_mouse_exited():
	$AnimationPlayer.play_backwards("CorruptModeMouseOver")
	$ModeDescriptionLabel.set_text("")
	OnMode = null

func _on_WormModeMouseOver_mouse_entered():
	#$ModeDescriptionLabel.set_text("Complete one of the main modes to access this mode.\nBecome the worm and corrupt computers around the world!")
	pass

func _on_WormModeMouseOver_mouse_exited():
	#$ModeDescriptionLabel.set_text("")
	pass



func _on_BackToMainMenu_pressed():
	get_tree().change_scene_to(MainMenuScene)
