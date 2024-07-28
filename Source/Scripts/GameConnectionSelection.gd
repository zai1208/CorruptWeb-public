extends Control





var roomData = {}
var PlayerData
func _ready():
	PlayerData = {"PlayerName" : str(Global.PlayerName)} #More Data to be added later
	
	#get_tree().connect("network_peer_connected", self, "_player_connected")
	#get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	$Selection/InfoPopup/InfoLabel.set_text("Connecting...")
	$Selection/InfoPopup.show()
	var net = NetworkedMultiplayerENet.new()
	net.create_client(str(Global.ServerIP), int(Global.ServerPort))
	get_tree().network_peer = net


func _on_Button2_pressed():
	$Selection/InfoPopup/InfoLabel.set_text("Connecting...")
	$Selection/InfoPopup.show()
	var net = NetworkedMultiplayerENet.new()
	net.create_client(str(Global.ServerIP), int(Global.ServerPort))
	get_tree().network_peer = net
	

func _connected_ok():
	$Selection/InfoPopup/InfoLabel.set_text("Connected")
	$Selection/ConnectedTimer.start()
	
func _on_ConnectedTimer_timeout():
	$Selection/InfoPopup.hide()
	$Selection/InfoPopup/InfoLabel.set_text("")
	$MultiplayerConnected/RequestList.start()
	$Selection.visible = false
	$MultiplayerConnected.visible = true

func _on_RequestList_timeout():
	rpc_id(1, "playerData", PlayerData) #rpc_id 1
	
	
remote func RoomList(room_List):
	roomData = room_List
	for i in room_List:
		var button = Button.new()
		button.name = str(i)
		button.add_to_group("RoomListButtons")
		button.connect("pressed", self, "RoomButton_pressed", [button])
		if room_List[str(i)]["CurrentPlayers"] == room_List[str(i)]["MaxPlayerCount"]:
			button.text = str(i) + "(FULL)"
		else:
			button.text = str(i)
		
		$MultiplayerConnected/ScrollContainer/VBoxContainer.add_child(button)

func RoomButton_pressed(button):
	if str(button.name) in roomData:
		$MultiplayerConnected/RoomInfo/RoomName.set_text(str(button.name))
		if roomData[str(button.name)]["CurrentPlayers"] == roomData[str(button.name)]["MaxPlayerCount"]:
			$MultiplayerConnected/RoomInfo/Count.set_text(str(roomData[str(button.name)]["CurrentPlayers"]) + "/" + str(roomData[str(button.name)]["MaxPlayerCount"]) + " (FULL)")
		else:
			$MultiplayerConnected/RoomInfo/Count.set_text(str(roomData[str(button.name)]["CurrentPlayers"]) + "/" + str(roomData[str(button.name)]["MaxPlayerCount"]))
	
		$MultiplayerConnected/RoomInfo/GameMode.set_text("Game Mode: " + roomData[str(button.name)]["RoomMode"])
		$MultiplayerConnected/RoomInfo.visible = true


func _on_Connect_pressed():
	Global.ServerIP = $MultiplayerConnected/IP.text
	Global.ServerPort = $MultiplayerConnected/Port.text
	get_tree().change_scene("res://Source/Scenes/Lobby.tscn")

func JoinServer(ip, port):
	get_tree().network_peer = null
	Global.GameServerIP = str(ip)
	Global.GameServerPort = int(port)
	get_tree().change_scene("res://Source/Scenes/Lobby.tscn")
	
	
func _on_JoinPrivateGame_pressed():
	if not $MultiplayerConnected/EnterGameCode.text.empty():
		var code = $MultiplayerConnected/EnterGameCode.text
		rpc_id(1, "RoomSearch", int(code), get_tree().get_network_unique_id())


remote func ConnectToGameServerPrivate(ip, port, room_code):
	Global.PrivateRoom = true
	Global.PrivateRoomCode = int(room_code)
	JoinServer(str(ip), int(port))
	
	
remote func ConnectToGameServerPublic(ip, port):
	Global.PrivateRoom = false
	JoinServer(str(ip), int(port))
	
	
	

	
	


func _on_CreatePublicRoom_pressed():
	rpc_id(1, "CreateRoom", 6, "CorruptedMode", get_tree().get_network_unique_id(), str(Global.PlayerName), false) #CreateRoom(maxPlayerSize, gameMode, id, roomName, game_private):


func _on_CreatePrivateRoom_pressed():
	rpc_id(1, "CreateRoom", 6, "CorruptedMode", get_tree().get_network_unique_id(), str(Global.PlayerName), true)
