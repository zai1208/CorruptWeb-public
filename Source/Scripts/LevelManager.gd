extends Node





export var Levels_Data ={
   "Level1":{
	  "LevelName":"Level 1: ...",
	  "LevelResource":"...",
	  "LevelImage":"res://Source/Images/image_placeholder.png"
   },
   "Level2":{
	  "LevelName":"Level 2: ...",
	  "LevelResource":"...",
	  "LevelImage":"res://Source/Images/image_placeholder.png"
   },
   "Level3":{
	  "LevelName":"Level 3: ...",
	  "LevelResource":"...",
	  "LevelImage":"res://Source/Images/image_placeholder.png"
   }
}#List of Maps


export var List_of_Types = ["name", "resource", "image"]



func _ready():
	pass
	
	
func get_levels():
	return Levels_Data
	
func get_data(type, for_what):
	var tp = type.to_lower()
	if tp in List_of_Types:
		if tp == "name":
			 return Levels_Data[for_what]["LevelName"]
		if tp == "resource":
			return Levels_Data[for_what]["LevelResource"]
		if tp == "image":
			return Levels_Data[for_what]["LevelImage"]
			



