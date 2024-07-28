extends Node2D


#475

var LastFloatingPlatformPositionX = 680
var LastEnemySpawnedPositionX = 700
var LastPowerUpSpawnedPositionX = 1177
#onready var FloatingPlatform = preload("res://Source/Scenes/Floating-Platform-01.tscn").instance()
var SpawnedEnemyNumber = 0
var RequiredDataNumber
var KilledEnemys = 0
var CollectedData = 0 
var SpawnedEnemyArray = []
var MinDestoryedEnemyNumber = 15
var DestroyedEnemyNumber = 0
var PauseMenuEnabled = false
func _ready():
	MainMenuMusicSound.stop()
	$WholeSceneDeath.play("Reset")
	$Player/ShakeGlitchEffect.visible = false
	
	for i in range(60):
		generate_platforms()
	for i in range(33):
		generate_enemys()
	for i in range(100):
		generate_powerup()
		
	if Global.PlayingTutorial == true:
		pass
		
	if Global.PlayingMultiplayer == true:
		print(Global.OtherPlayerData)
		for p in Global.OtherPlayerData:
			var Multiplayer_PlayerInstance = preload("res://Source/Scenes/Player_Multiplayer.tscn").instance()
			Multiplayer_PlayerInstance.name = (str(p))
			Multiplayer_PlayerInstance.set_network_master(p)
			add_child(Multiplayer_PlayerInstance)
			print("Added Player with the name: " + str(Multiplayer_PlayerInstance.name) )
		
	if LevelGenerationData.GAME_MODE == 2: #Recovery Mode
		$Player/Camera2D/PlayerHUD/GainedData.visible = true
		RequiredDataNumber = SpawnedEnemyNumber * 500
		$Player/Camera2D/PlayerHUD/GainedData/DataCollected.set_text("Data Collected: " + str(CollectedData) + "MB/" + str(RequiredDataNumber) + "MB")
	else:
		$Player/Camera2D/PlayerHUD/GainedData.visible = false
		
func glitch_view():
	$GlitchTimer.start()
	$Player/ShakeGlitchEffect.visible = true
	$GlitchEffectSound.play()
	
func _on_GlitchTimer_timeout():
	$Player/ShakeGlitchEffect.visible = false


func refreshData_collected():
	$Player/Camera2D/PlayerHUD/GainedData/DataCollected.set_text("Data Collected: " + str(CollectedData) + "MB/" + str(RequiredDataNumber) + "MB")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		glitch_view()


func _on_AudioStreamPlayer_finished():
	$Player/ShakeGlitchEffect.visible = false


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		glitch_view()
	
	
	
	
func generate_platforms():
	if Global.MultiplayerHost == true or Global.PlayingMultiplayer == false:
		var random = RandomNumberGenerator.new()
		random.randomize()
		var number = random.randi_range(0, 10)
		if number < 3:
			
			print("Genrating Level")
			var random_1 = RandomNumberGenerator.new()
			random_1.randomize()
			
			var yAxisVariation = RandomNumberGenerator.new()
			yAxisVariation.randomize()
			var yAxisNumber = yAxisVariation.randi_range(12, 26)
			
			var FloatingPlatform = preload("res://Source/Scenes/Moving-Platform-01.tscn").instance()
			var number_1 = random.randi_range(250, 950)
			
			FloatingPlatform.position.x = LastFloatingPlatformPositionX + int(number_1) + 55
			#print("s " + str(LastFloatingPlatformPositionX))
			FloatingPlatform.position.y = 400 + yAxisNumber
			LastFloatingPlatformPositionX = FloatingPlatform.position.x
			if Global.PlayingMultiplayer == true and Global.MultiplayerHost == true:
				rpc("SyncPlatform", FloatingPlatform.position, get_tree().get_network_unique_id())
				
			add_child(FloatingPlatform)


func _on_Timer_timeout():
	#DiscordRP.setup_party(5, 4096)
	pass


func generate_enemys():
	if Global.MultiplayerHost == true or Global.PlayingMultiplayer == false:
		
		if LevelGenerationData.GAME_MODE == 1 or LevelGenerationData.GAME_MODE == 2: #Corrupted Game Mode and Recovery Game Mode
			var random = RandomNumberGenerator.new()
			random.randomize()
			var number = random.randi_range(0, 10)
			if number < 4:
				
				var random_1 = RandomNumberGenerator.new()
				random_1.randomize()
				var number_1 = random_1.randi_range(60, 230)
				
				var random_2 = RandomNumberGenerator.new()
				random_2.randomize()
				var enemy_type = random_2.randi_range(1, 1)
				var set_enemyType
				#if enemy_type == 1:
				var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
				set_enemyType = em
				$Enemys.add_child(em)
				em.position.x = LastEnemySpawnedPositionX + int(number_1)
				LastEnemySpawnedPositionX = em.position.x
				em.position.y = 450
				print(em.position)
				SpawnedEnemyNumber += 1
				reload_EnemyCollison(em)
				if Global.PlayingMultiplayer == true and Global.MultiplayerHost == true:
					rpc("SyncEnemy", em.position, get_tree().get_network_unique_id(), em.name)
	#			elif enemy_type == 2:
	#				#var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
	#				#set_enemyType == em
	#				pass
	#			elif enemy_type == 3:
	#				#var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
	#				#set_enemyType == em
	#				pass
	#			elif enemy_type == 4:
	#				#var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
	#				#set_enemyType == em
	#				pass
				
			
			
			

func reload_EnemyCollison(enemy):
	for i in SpawnedEnemyArray:
		#i.add_collision_exception_with(enemy)
		#enemy.add_collision_exception_with(i)
		pass
	SpawnedEnemyArray.append(enemy)



remote func SyncPlatform(pos, id):
	var FloatingPlatform = preload("res://Source/Scenes/Moving-Platform-01.tscn").instance()
	FloatingPlatform.position = pos
	add_child(FloatingPlatform)
	
	
remote func SyncEnemy(pos, id, em_name):
	var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
	em.position = pos
	em.name = em_name
	$Enemys.add_child(em)
	print("Enemy Spawned In Name: " + str(em.name))

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "PlayerDeathAnimation":
		print("Player Died")
		$WholeSceneDeath.play("AfterPlayerDeath")
		$Player.reset()
		for i in range(15):
			generate_enemys()
		$Player.ControlsDisabed = false


func generate_powerup():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var powerup_num = random.randi_range(0, 11)
	
	if powerup_num == 1:
		var power_up = preload("res://Source/Scenes/PowerUps/HealthPowerup.tscn").instance()
		var x_pos = RandomNumberGenerator.new()
		x_pos.randomize()
		var x_pos_num = x_pos.randi_range(1000, 1800)
		power_up.position.x = LastPowerUpSpawnedPositionX + int(x_pos_num)
		LastPowerUpSpawnedPositionX = power_up.position.x
		power_up.position.y = 507
		$AddedPowerUps.add_child(power_up)
		
		
	if powerup_num == 2:
		var power_up = preload("res://Source/Scenes/PowerUps/ElectricPowerup.tscn").instance()
		var x_pos = RandomNumberGenerator.new()
		x_pos.randomize()
		var x_pos_num = x_pos.randi_range(350, 700)
		power_up.position.x = LastPowerUpSpawnedPositionX + int(x_pos_num)
		LastPowerUpSpawnedPositionX = power_up.position.x
		power_up.position.y = 507
		$AddedPowerUps.add_child(power_up)
		

#func destroyed_Enemy(em_name):
#	rpc("DestroyedEnemy", em_name)
	
	
	
#remote func DestroyedEnemy(em_name):
#	if has_node(str(em_name)):
#		get_node(str(em_name)).MultiplayerDestroy()


#func UpdateEnemyPos(pos, em_name):
#	if $Enemys.has_node(str(em_name)) == true:
#		var node_path = "Enemys/" + str(em_name)
#		get_node(str(node_path)).global_position = pos


func _on_BGMusic_finished():
	if $Player.PurposePause == false:
		$BGMusic.play(0)


func checkEnemyNumberReached():
	if LevelGenerationData.GAME_MODE == 1:
		if DestroyedEnemyNumber == MinDestoryedEnemyNumber:
			endGame()
		
	elif LevelGenerationData.GAME_MODE == 2:
		if CollectedData == RequiredDataNumber:
			endGame()
		
		
func endGame():
	if LevelGenerationData.GAME_MODE == 1:
		var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_CorruptedMode")
		if not mission_list == null:
			if not LevelGenerationData.PLACE_SET == null:
				if not LevelGenerationData.MISSION_NAME == null:
					var t = mission_list
					t["Missions"][str(LevelGenerationData.PLACE_SET)][str(LevelGenerationData.MISSION_NAME)] = {"Completed" : true}
					SettingsManager.addSetGameSave("MissionList_CorruptedMode", t)
					endGameStuff()
					
				else:
					OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level before entering the level?', 'CorruptWeb')
					get_tree().quit()
					
			else:
				OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level before entering the level?', 'CorruptWeb')
				get_tree().quit()
				
	elif LevelGenerationData.GAME_MODE == 2:
		var mission_list = SettingsManager.getGameSaveKeyValue("MissionList_RecoveryMode")
		var total_collected = SettingsManager.getGameSaveKeyValue("RecoveryModeTotalData")
		if not mission_list == null:
			if not LevelGenerationData.PLACE_SET == null:
				if not LevelGenerationData.MISSION_NAME == null:
					var t = mission_list
					t["Missions"][str(LevelGenerationData.PLACE_SET)][str(LevelGenerationData.MISSION_NAME)] = {"Completed" : true}
					SettingsManager.addSetGameSave("MissionList_RecoveryMode", t)
					
					if total_collected == null:
						total_collected = 0
						total_collected += int(CollectedData)
						SettingsManager.addSetGameSave("RecoveryModeTotalData", int(total_collected))
						endGameStuff()
						
					elif not total_collected == null:
						total_collected += int(CollectedData)
						SettingsManager.addSetGameSave("RecoveryModeTotalData", int(total_collected))
						endGameStuff()
					
				else:
					OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level before entering the level?', 'CorruptWeb')
					get_tree().quit()
					
			else:
				OS.alert('ERROR: Requested Level Variables are NULL. Have you selected a level before entering the level?', 'CorruptWeb')
				get_tree().quit()
			
			
func endGameStuff():
	$CanvasLayer2.LevelCompleted(int(DestroyedEnemyNumber))
	
		
	
	
	


func _on_TestTimer_timeout():
	#endGameStuff()
	pass


func _input(event):
	if event.is_action_pressed("Escape") and Global.Playing == true:
		#print("please dont fire twice :(")
		pass

