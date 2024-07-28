extends Node


var ConnectedToServer = false
var ServerIP = "127.0.0.1" # Local host for testing reasons, german server IP is 38.242.159.251
var ServerPort = 6969 # Usually Open Port
var AuthKey
var PlayerName = "TestName1"
var PlayingMultiplayer = false
var ConnectedPlayersData = {}
var PlayerDat = {"PlayerName" : "4096"}
var OtherPlayerData = {}
var email = null
var PrivateRoom = false
var PrivateRoomCode
var MultiplayerHost = false
var GameServerIP
var GameServerPort
var PlayingTutorial = false
var Playing = false
