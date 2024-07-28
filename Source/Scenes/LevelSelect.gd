extends Control






var TotalMissions = 42 
var AfricaMissionNum = 7
var AustraliaMissionNum = 7
var AsiaMissionNum = 7
var NorthAmericaMissionNum = 7
var SouthAmericaMissionNum = 7
var EuropeMissionNum = 7
var Missions = {"Africa" : {}, "Asia": {}, "Australia" : {}, "NorthAmerica" : {}, "SouthAmerica" : {}, "Europe" : {}}
func _ready():
	#var already_generatedMissions = SettingsManager.getGameSaveKeyValue("GeneratedMission")
	#if already_generatedMissions == null:
	generate_MissionsAfrica()
	generate_MissionsAsia()
	generate_MissionEurope()
	generate_MissionsNorthAmerica()
	generate_MissionsSouthAmerica()
	generate_MissionAustralia()





func generate_MissionsAfrica():
	
	for i in range(int(AfricaMissionNum)):
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(250, 360)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(351, 363)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
		Missions["Africa"][str(random_name)] = data_dict
		reloadDots()
				
				
func generate_MissionsAsia():
	
	for i in range(int(AsiaMissionNum)):
		
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(154, 248)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(420, 521)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
		Missions["Asia"][str(random_name)] = data_dict
		reloadDots()
				
				
func generate_MissionsSouthAmerica():
	
	for i in range(int(SouthAmericaMissionNum)):
		
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(288, 338)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(195, 233)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
#		for t in Missions["SouthAmerica"]:
#			if not posVector == ["SouthAmerica"][t]["MapPos"] or Missions["SouthAmerica"].size() < SouthAmericaMissionNum:
		Missions["SouthAmerica"][str(random_name)] = data_dict
		reloadDots()
				
func generate_MissionsNorthAmerica():
	
	for i in range(int(NorthAmericaMissionNum)):
		
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(174, 234)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(100, 195)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
		Missions["NorthAmerica"][str(random_name)] = data_dict
		reloadDots()
	
	
func generate_MissionEurope():
	
	for i in range(int(EuropeMissionNum)):
		
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(196, 210)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(330, 425)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
		Missions["Europe"][str(random_name)] = data_dict
		reloadDots()
				
				
				
				
				
func generate_MissionAustralia():
	
	for i in range(int(AustraliaMissionNum)):
		
		
		var y_generationPos = RandomNumberGenerator.new()
		y_generationPos.randomize()
		var y_generationPosNum = y_generationPos.randi_range(344, 363)
		
		
		var x_generationPos = RandomNumberGenerator.new()
		x_generationPos.randomize()
		var x_generationPosNum = x_generationPos.randi_range(525, 577)
		
		
		var posVector = Vector2(x_generationPosNum, y_generationPosNum)
		var random_name = generateRandomName()
		var data_dict = {"MapPos" : posVector}
		Missions["Australia"][str(random_name)] = data_dict
		reloadDots()


func generateRandomName():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_num = random.randi_range(11111, 99999)
	var random_name = "NET_" + str(random_num)
	return random_name
	



func reloadDots():
	for i in Missions:
		for t in Missions[i]:
			if "MapPos" in Missions[i][t]: # var Missions = {"Africa" : {}, "Asia": {}, "Australia" : {}, "NorthAmerica" : {}, "SouthAmerica" : {}, "Europe" : {}}
				var dot = preload("res://Source/Scenes/RedDotScene.tscn").instance()
				add_child(dot)
				dot.rect_position = Missions[i][t]["MapPos"]
	
	
