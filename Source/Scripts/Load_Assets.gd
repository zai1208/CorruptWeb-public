extends Node

var loaded = false
var assets = {}
var database ={
   "MainMenu":"res://Source/Scenes/MainMenu.tscn",
   "Levels":"res://Source/Scenes/Levels.tscn",
   "Image_Placeholder" : "res://Source/Images/image_placeholder.jpg",
	"LevelSelectorScene" : "res://Source/Scenes/New_LevelSelector.tscn",
	"ChatCutsceneScene" : "res://Source/Scenes/StartingCutscene.tscn",
	"ModeSelectorScene" : "res://Source/Scenes/ModeSelection.tscn"
}
func _ready():
	load_assets()
	



func get_asset(asset_name):
	if asset_name in assets:
		var k = assets[asset_name]
		print(assets)
		return k 
	else:
		print_debug("Asset not found in Asset Database!")
	
	
func load_assets():
	for i in database:
		var d = database[i]
		var p = load(d)
		assets[i] = p
		print(assets)
	loaded = true
