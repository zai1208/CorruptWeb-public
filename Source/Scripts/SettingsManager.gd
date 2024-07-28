extends Node




var first_time = false
var default_keyPath = "user://CorruptWeb/save/secured.cw" 
var default_savePath = "user://CorruptWeb/save/save.cw" 
onready var loaded = false
onready var base_save = {"Settings": {"Debug" : {} }, "GameSave" : {}}
var GameSave 
func _ready():
	LoadSettings() 




func LoadSettings():
	var file_key = File.new()
	var dir = Directory.new()
	if not dir.dir_exists("user://CorruptWeb"):
		dir.make_dir_recursive("user://CorruptWeb")
		print_debug("Created Dir CorruptWeb")
		if not dir.dir_exists("user://CorruptWeb/save"):
			dir.make_dir_recursive("user://CorruptWeb/save")
			print_debug("Created Dir CorruptWeb/save")
		if not file_key.file_exists("user://CorruptWeb/README.txt"):
			file_key.open("user://CorruptWeb/README.txt", File.WRITE)
			file_key.store_string("IMPORTANT!\nPLEASE DO NOT MODIFY ANY OF THESE FILES THAT ARE IN ANY DIRECTORY THAT IS RELATED TO THE GAME! YOU COULD LOSE YOUR GAME SAVE!")
			file_key.close()
		
		if not file_key.file_exists(str(default_keyPath)):
			file_key.open_encrypted_with_pass(str(default_keyPath), File.WRITE, "08f47f029431480562060a0ff765747895fd3b135e0e9a05daf13da5a41e8746")
			var gen_key = Generate_Key()
			file_key.store_string(str(gen_key))
			file_key.close()
			
		var file = File.new()
		if file.file_exists(str(default_keyPath)):
			file.open_encrypted_with_pass(str(default_keyPath), File.READ, "08f47f029431480562060a0ff765747895fd3b135e0e9a05daf13da5a41e8746")
			var l = file.get_as_text()
			file.close()
			if not file.file_exists(str(default_savePath)):
				file.open_encrypted_with_pass(str(default_savePath), File.WRITE, str(l))
				file.store_var(base_save)
				file.close()
			else:
				if file.file_exists(str(default_savePath)):
					file.open_encrypted_with_pass(str(default_savePath), File.READ, str(l))
					var k = file.get_var()
					GameSave = k
					file.close()
					
					print(GameSave)
					loaded = true
	
	else:
		var file = File.new()
		if file.file_exists(str(default_keyPath)):
			file.open_encrypted_with_pass(str(default_keyPath), File.READ, "08f47f029431480562060a0ff765747895fd3b135e0e9a05daf13da5a41e8746")
			var l = file.get_as_text()
			file.close()
			if not file.file_exists(str(default_savePath)):
				file.open_encrypted_with_pass(str(default_savePath), File.WRITE, str(l))
				file.store_var(base_save)
				file.close()
			else:
				if file.file_exists(str(default_savePath)):
					file.open_encrypted_with_pass(str(default_savePath), File.READ, str(l))
					var k = file.get_var()
					GameSave = k
					file.close()
					
					print(GameSave)
					loaded = true
					l = null #Clear from Memory to prevent Memory Snooping and getting the file access key
func Generate_Key():
	var t = RandomNumberGenerator.new()
	randomize()
	var p = t.randi_range(1, 9079)
	var i = "KEY_" + str(p)
	var h = i.sha256_text()
	return h
	
	
	
func addDebugSetting(key, value):
	if loaded == true and not GameSave == null:
		#{"Settings": {"Debug" : {} }, "GameSave" : {}}
		GameSave["Settings"]["Debug"][str(key)] = value
		Save()
	else:
		OS.alert('ERROR: Unable to access save file. Please check if the save files exist.', 'CorruptWeb')
	
func addSetGameSave(key, value):
	reloadGameSave()
	#{"Settings": {"Debug" : {} }, "GameSave" : {}}
	GameSave["GameSave"][str(key)] = value
	Save()
	
func getGameSaveKeyValue(keyName):
	reloadGameSave()
	if keyName in GameSave["GameSave"]:
		var data = GameSave["GameSave"][str(keyName)]
		return data
	else:
		return null

func Save():
	var file = File.new()
	file.open_encrypted_with_pass(str(default_keyPath), File.READ, "08f47f029431480562060a0ff765747895fd3b135e0e9a05daf13da5a41e8746")
	var l = file.get_as_text()
	file.close()
	file.open_encrypted_with_pass(str(default_savePath), File.WRITE, str(l))
	file.store_var(GameSave)
	file.close()
	
	
func reloadGameSave():
	var file = File.new()
	file.open_encrypted_with_pass(str(default_keyPath), File.READ, "08f47f029431480562060a0ff765747895fd3b135e0e9a05daf13da5a41e8746")
	var l = file.get_as_text()
	file.close()
	file.open_encrypted_with_pass(str(default_savePath), File.READ, str(l))
	var k = file.get_var()
	GameSave = k
	file.close()
	
	
