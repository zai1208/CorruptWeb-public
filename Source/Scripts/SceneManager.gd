extends Node






var scenes = {"mainmenu" : "res://Source/Scenes/New_LevelSelector.tscn", "main_menu" : "res://Source/Scenes/MainMenu.tscn"} #Scene Data
func _ready():
	pass 







func change_scene(scene_tag):
	var select_scene = scene_tag.to_lower()
	if not select_scene in scenes:
		print("Scene not in Scene Data!")
	else:
		var p = scenes[str(select_scene)]
		get_tree().change_scene(p)
		
