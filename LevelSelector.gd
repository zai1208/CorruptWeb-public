extends Control





var missions 
var currentPlaceSet = "Africa"
var LevelAlreadyCompleted = false
func _ready():
	#$MissionList/AnimationPlayer.play("LoadImage")
	if not MainMenuMusicSound.playing == true:
		MainMenuMusicSound.play()
	$AnimationPlayer.play("FadeIn")
	var mission_corrupt = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
	var mission_recovery = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
	
	if not mission_corrupt == null or not mission_recovery == null:
		if LevelGenerationData.GAME_MODE == 1:
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
			if not mission_list == null:
				missions = mission_list
				update_MissionButtons()
				
		elif LevelGenerationData.GAME_MODE == 2:
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
			if not mission_list == null:
				missions = mission_list
				update_MissionButtons()
			
			var total_data = SettingsManager.getGameSaveKeyValue("RecoveryModeTotalData")
			if total_data == null:
				SettingsManager.addSetGameSave("RecoveryModeTotalData", 0)
				total_data = 0
				
				if LevelGenerationData.GAME_MODE == 2:
					if total_data < 1000:
						$MissionList/MissionInfo/ColorRect/DataCorrupted.set_text("TOTAL DATA COLLECTED: " + str(total_data) + "MB")
						$MissionList/MissionInfo/ColorRect/DataCorrupted.visible = true
					elif total_data > 1000:
						total_data /= 1000
						$MissionList/MissionInfo/ColorRect/DataCorrupted.set_text("TOTAL DATA COLLECTED: " + str(total_data) + "GB")
						$MissionList/MissionInfo/ColorRect/DataCorrupted.visible = true
			
				
			#for i in mission_list["Missions"]:
				#for t in mission_list["Missions"][i]:
					#pass
					
			elif not total_data == null:
				if LevelGenerationData.GAME_MODE == 2:
					if total_data < 1000:
						$MissionList/MissionInfo/ColorRect/DataCorrupted.set_text("TOTAL DATA COLLECTED: " + str(total_data) + "MB")
						$MissionList/MissionInfo/ColorRect/DataCorrupted.visible = true
					elif total_data > 1000:
						total_data /= 1000
						$MissionList/MissionInfo/ColorRect/DataCorrupted.set_text("TOTAL DATA COLLECTED: " + str(total_data) + "GB")
						$MissionList/MissionInfo/ColorRect/DataCorrupted.visible = true
	
	else:
		
		if LevelGenerationData.GAME_MODE == 1:
			SettingsManager.addSetGameSave("MissionList_CorruptedMode", {"Missions" : {
				"Africa": {},
				"Asia" : {},
				"South America" : {},
				"North America" : {},
				"Europe" : {}, 
				"Australia" : {}
				
			}})
			
			generate_Missions("Africa")
			generate_Missions("Asia")
			generate_Missions("Australia")
			generate_Missions("South America")
			generate_Missions("North America")
			generate_Missions("Europe")
			
		elif LevelGenerationData.GAME_MODE == 2:
			SettingsManager.addSetGameSave("MissionList_RecoveryMode", {"Missions" : {
				"Africa": {},
				"Asia" : {},
				"South America" : {},
				"North America" : {},
				"Europe" : {}, 
				"Australia" : {}
				
			}})
			
			generate_Missions("Africa")
			generate_Missions("Asia")
			generate_Missions("Australia")
			generate_Missions("South America")
			generate_Missions("North America")
			generate_Missions("Europe")
		




func generate_Missions(place_name):
	for i in range(10):
		if LevelGenerationData.GAME_MODE == 1:
			var nam = generate_RandomName()
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
			if not mission_list == null:
				if mission_list["Missions"].has(str(place_name)) == true:
					var dat = mission_list["Missions"][str(place_name)]
					dat[str(nam)] = {"Completed" : false}
					SettingsManager.addSetGameSave("MissionList_CorruptedMode", mission_list)
					missions = mission_list
					update_MissionButtons()
					#$SettingsManager.addSetGameSave("MissionList", )
					
					
		elif LevelGenerationData.GAME_MODE == 2:
			var nam = generate_RandomName()
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
			if not mission_list == null:
				if mission_list["Missions"].has(str(place_name)) == true:
					var dat = mission_list["Missions"][str(place_name)]
					dat[str(nam)] = {"Completed" : false}
					SettingsManager.addSetGameSave("MissionList_RecoveryMode", mission_list)
					missions = mission_list
					update_MissionButtons()
			
		
	
	
	
	show_image(str(place_name))
	
	
	
	
func show_image(place_name):
	var path = "res://Source/Images/Level/" + str(place_name) + ".png"
	var tex = load(path)
	$MissionList/AnimationPlayer.play("LoadImage")
	$MissionList/PlaceImage.texture = tex
	currentPlaceSet = str(place_name)
	
func generate_RandomName():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_num = random.randi_range(11111, 99999)
	var random_name = "NETWORK_" + str(random_num)
	return random_name
	
func update_MissionButtons():
	if not missions == null:
		for n in $MissionList/ScrollContainer/VBoxContainer.get_children():
			$MissionList/ScrollContainer/VBoxContainer.remove_child(n)
			n.free()
			
		for i in missions["Missions"][str(currentPlaceSet)]:
			add_button(str(i))
			print("Added Mission Buttons")
	
func add_button(button_name):
	var b = Button.new()
	b.name = button_name
	b.text = str(button_name)
	$MissionList/ScrollContainer/VBoxContainer.add_child(b)
	b.add_to_group("MissionButtons")
	for i in get_tree().get_nodes_in_group("MissionButtons"):
		b.connect("pressed", self, "_MissionButtonPressed", [b])


func _on_PlaceSelectButton_pressed():
	var t = $MissionList/PlaceSelectButton.text
	if t == "AFRICA":
		$MissionList/PlaceSelectButton.text = "ASIA"
		show_image("Asia")
		currentPlaceSet = "Asia"
		update_MissionButtons()
	elif t == "ASIA":
		$MissionList/PlaceSelectButton.text = "AUSTRALIA"
		show_image("Australia")
		currentPlaceSet = "Australia"
		update_MissionButtons()
	elif t == "AUSTRALIA":
		$MissionList/PlaceSelectButton.text = "SOUTH AMERICA"
		show_image("South America")
		currentPlaceSet = "South America"
		update_MissionButtons()
	elif t == "SOUTH AMERICA":
		$MissionList/PlaceSelectButton.text = "NORTH AMERICA"
		show_image("North America")
		currentPlaceSet = "North America"
		update_MissionButtons()
	elif t == "NORTH AMERICA":
		$MissionList/PlaceSelectButton.text = "EUROPE"
		show_image("Europe")
		currentPlaceSet = "Europe"
		update_MissionButtons()
	elif t == "EUROPE":
		$MissionList/PlaceSelectButton.text = "AFRICA"
		show_image("Africa")
		currentPlaceSet = "Africa"
		update_MissionButtons()


func _MissionButtonPressed(button):
	if missions["Missions"][str(currentPlaceSet)].has(str(button.name)):
		LevelGenerationData.PLACE_SET = str(currentPlaceSet)
		LevelGenerationData.MISSION_NAME = str(button.name)
		if missions["Missions"][str(currentPlaceSet)][str(button.name)]["Completed"] == false:
			$MissionList/MissionInfo/ColorRect/MissionCompleted.set_text("Not Completed")
			$MissionList/MissionInfo/ColorRect/MissionCompleted.add_color_override("font_color", Color(1, 0, 0, 1))                       
			LevelAlreadyCompleted = false
			$MissionList/MissionInfo/ColorRect/PlayButton.disabled = false
			$MissionList/MissionInfo/ColorRect/PlayButton.visible = true
		else:
			$MissionList/MissionInfo/ColorRect/MissionCompleted.set_text("Completed")
			$MissionList/MissionInfo/ColorRect/MissionCompleted.add_color_override("font_color", Color(0, 1, 0, 1))   
			LevelAlreadyCompleted = true
			$MissionList/MissionInfo/ColorRect/PlayButton.visible = false
			$MissionList/MissionInfo/ColorRect/PlayButton.disabled = true
			$MissionList/MissionInfo/ColorRect/PlayButton.visible = true
		
		


func _on_PlayButton_pressed():
	if not LevelGenerationData.PLACE_SET == null:
		if not LevelGenerationData.MISSION_NAME == null:
			if not LevelAlreadyCompleted == true:
				print("Load")
				var random = RandomNumberGenerator.new()
				random.randomize()
				var random_number = random.randi_range(0, 4)
				if random_number == 1:
					get_tree().change_scene("res://Source/Scenes/LevelTemplate01.tscn")
				elif random_number == 2:
					get_tree().change_scene("res://Source/Scenes/LevelTemplate02.tscn")
				elif random_number == 3:
					get_tree().change_scene("res://Source/Scenes/LevelTemplate03.tscn")
				elif random_number == 4:
					get_tree().change_scene("res://Source/Scenes/LevelTemplate04.tscn")
					
				elif not random_number == 1 or not random_number == 2 or not random_number == 3 or not random_number == 4:
					get_tree().change_scene("res://Source/Scenes/LevelTemplate01.tscn")
					
		else:
			OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level?', 'CorruptWeb')
	else:
		OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level?', 'CorruptWeb')


func _on_ToMainMenu_pressed():
	get_tree().change_scene("res://Source/Scenes/ModeSelection.tscn")
