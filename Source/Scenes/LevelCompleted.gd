extends CanvasLayer



var IgnoredNodes = ["Timer", "AnimationPlayer"]
var num = 0

func _ready():
	set_visiblity(false) 

func set_visiblity(vis):
	get_tree().paused = vis
	for n in get_children():
		if not n.name in IgnoredNodes:
			n.visible = vis
	

func _process(delta):
	pass
			
func LevelCompleted(NumberOfEnemysDestroyed):
	num = NumberOfEnemysDestroyed
	get_tree().paused = true
	if not num == 0:
		$Control/Label3.set_text("Enemies Destroyed: " + str(num))
		set_visiblity(true)
	
	
func _on_LevelSelection_pressed():
	set_visiblity(false)
	get_tree().change_scene("res://Source/Scenes/LevelSelector.tscn")


func _on_MainMenu_pressed():
	set_visiblity(false) 
	print("Changing to main menu")
	get_tree().change_scene("res://Source/Scenes/MainMenu.tscn")


func _on_QuitToDesktop_pressed():
	set_visiblity(false)
	GameExit.CheckAndQuit()
