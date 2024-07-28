extends Control

var GameServerTesting = false



var AlreadyAddedNames = []
var LevelTemplate01 = preload("res://Source/Scenes/LevelTemplate01.tscn").instance()
var LevelTemplate02 = preload("res://Source/Scenes/LevelTemplate02.tscn").instance()
var LobbyDisabled = false
var image_selection = []
var image_num = 0
var maxImageNum = 1
var GameUItesting = false
var Game_ModeSelectionNum = 0
var GameModes = ["Corrupted Mode", "Recovery Mode", "Worm Mode"]
var Set_GameMode = "Corrupted Mode"
func _ready():
	if GameUItesting == false:
		var net = NetworkedMultiplayerENet.new()
		#net.create_client("127.0.0.1", 6969) # Game Server testing
		var error : int = net.create_client(str(Global.GameServerIP), int(Global.GameServerPort))
		print(error)
		get_tree().network_peer = net
		get_tree().set_network_peer(net)
		print("Client Online!")
		$SendPlayerData.start()
		Global.PlayingMultiplayer = true
		
		
		if Global.PrivateRoom == true:
			$PrivateRoomCode.set_text("Room Code: " + str(Global.PrivateRoomCode))
			$PrivateRoomCode.visible = true
		#rpc_id(1, "playerData", Global.PlayerDat, int(get_tree().get_network_unique_id()))
		
		
		if Global.MultiplayerHost == false:
			$Control2/LevelSelection/LeftArrow.modulate.a8 = 80
			$Control2/LevelSelection/RightArrow.modulate.a8 = 80
			
		elif Global.MultiplayerHost == true:
			$Control2/LevelSelection/LeftArrow.modulate.a8 = 255
			$Control2/LevelSelection/RightArrow.modulate.a8 = 255
			
	else:
		Global.MultiplayerHost = true
		
		
	
	
remote func RemotePrint(text):
	print(str(text))
	rpc_id(1, "RemotePrint", "Printed the text!")
	
remote func EnableStartButton():
	$StartGameButton.disabled = false
	
func load_levelTemplate(level_template):
	if level_template == 1:
		add_child(LevelTemplate01)
		
	elif level_template == 2:
		add_child(LevelTemplate02)
	
remote func LoadGame(gameMode, level_template):
	if gameMode == "Corrupted":
		LevelGenerationData.GAME_MODE = 1
	elif gameMode == "Recovery":
		LevelGenerationData.GAME_MODE = 2
	elif gameMode == "WormMode":
		LevelGenerationData.GAME_MODE = 3
		
	if level_template == 1:
		load_levelTemplate(level_template)
	elif level_template == 2:
		load_levelTemplate(level_template)

remote func chatMessage(message):
	var la = Label.new()
	la.set_text(str(message))
	$ChatBox/VBoxContainer.add_child(la)
	print("Player sent message!")
	
	
remote func UpdatePlayerData(id, data):
	Global.OtherPlayerData[int(id)] = data
	var la = Label.new()
	if "PlayerName" in data and not data["PlayerName"] in AlreadyAddedNames:
		la.set_text(str(data["PlayerName"]))
		$PlayerList/VBoxContainer.add_child(la)
		AlreadyAddedNames.append(str(data["PlayerName"]))

func _on_StartGameButton_pressed():
	rpc_id(1, "startGame", int(get_tree().get_network_unique_id()))



func send_message(text):
	rpc_id(1, "lobby_chatMessage", str(text), int(get_tree().get_network_unique_id()))


func _on_SendMessage_pressed():
	if not $Control/MessageLine.text.empty():
		send_message(str($Control/MessageLine.text))
		$Control/MessageLine.text = ""


func _on_SendPlayerData_timeout():
	rpc_id(1, "player_Data", Global.PlayerDat, int(get_tree().get_network_unique_id()))


func _input(event):
	if event.is_action_pressed("Enter") and LobbyDisabled == false:
		if not $Control/MessageLine.text.empty():
			send_message(str($Control/MessageLine.text))
			$Control/MessageLine.text = ""


func _on_CopyRoomCode_pressed():
	if Global.PrivateRoom == true:
		OS.set_clipboard(str(Global.PrivateRoomCode))

			
			
func update_image():
	$Control2/LevelSelection/LevelImage.texture = image_selection[int(image_num)]
	if Global.MultiplayerHost == true:
		rpc_id(1, "UpdateLevelSelectionImage", int(image_num))
			
func updateHost_vars():
	if Global.MultiplayerHost == true:
		$Control2/LevelSelection/LeftArrow.modulate.a8 = 255
		$Control2/LevelSelection/RightArrow.modulate.a8 = 255

remote func setMultiplayerHost():
	Global.MultiplayerHost = true
	updateHost_vars()

remote func UpdateLevelImage(image_n):
	image_num = image_n
	update_image()





func _on_LeftArrow_pressed():
	if Global.MultiplayerHost == true:
		if not image_selection == 0:
			image_num -= 1
			update_image()

func _on_RightArrow_pressed():
	if Global.MultiplayerHost == true:
		if not image_num == maxImageNum and image_num < image_selection.size():
			image_num += 1
			update_image()




func _on_GameModeSelectionLeft_pressed():
	if Global.MultiplayerHost == true:
		if not Game_ModeSelectionNum == 0:
			Game_ModeSelectionNum -= 1
			Set_GameMode = GameModes[Game_ModeSelectionNum]
			$Control2/LevelSelection/GameModeSelection.set_text(str(Set_GameMode))
			rpc_id(1, "ChangedGameModeSelection", Set_GameMode, get_tree().get_network_unique_id())
		
		


func _on_GameModeSelectionRight_pressed():
	if Global.MultiplayerHost == true:
		if not Game_ModeSelectionNum == 2:
			Game_ModeSelectionNum += 1
			Set_GameMode = GameModes[Game_ModeSelectionNum]
			$Control2/LevelSelection/GameModeSelection.set_text(str(Set_GameMode))
			rpc_id(1, "ChangedGameModeSelection", Set_GameMode, get_tree().get_network_unique_id())
			
		
remote func changed_gameMode(game_mode):
	$Control2/LevelSelection/GameModeSelection.set_text(str(game_mode))


