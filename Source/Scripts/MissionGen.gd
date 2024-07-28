extends Node


var not_set = 0
func _ready():
	var mission_corrupt = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
	var mission_recovery = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
	
	if mission_corrupt == null:
		not_set = 1
		var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
		if mission_list == null:
			
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
			
			
	if mission_recovery == null:
		not_set = 2
		var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
		if mission_list == null:
			
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
		if not_set == 1:
			var nam = generate_RandomName()
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
			if not mission_list == null:
				if mission_list["Missions"].has(str(place_name)) == true:
					var dat = mission_list["Missions"][str(place_name)]
					dat[str(nam)] = {"Completed" : false}
					SettingsManager.addSetGameSave("MissionList_CorruptedMode", mission_list)
					print("generated missions for 01")
					
					
		elif not_set == 2:
			var nam = generate_RandomName()
			var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
			if not mission_list == null:
				if mission_list["Missions"].has(str(place_name)) == true:
					var dat = mission_list["Missions"][str(place_name)]
					dat[str(nam)] = {"Completed" : false}
					SettingsManager.addSetGameSave("MissionList_RecoveryMode", mission_list)
					


func generate_RandomName():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_num = random.randi_range(11111, 99999)
	var random_name = "NETWORK_" + str(random_num)
	return random_name
	
	
