extends Node
onready var rpc
onready var application_id

func _ready():
	_init_discord_rpc()
	


func _init_discord_rpc() -> void:
	print("Initializing DiscordRPC")
	rpc = DiscordRPC.new()
	rpc.connect("rpc_error", self, "_on_rpc_error")
	add_child(rpc)
	rpc.connect("rpc_ready", self, "_on_rpc_ready")
	rpc.connect("rpc_closed", self, "_on_rpc_closed")
	rpc.establish_connection(998098800969265262)
	
	
	
func _on_rpc_ready(user: Dictionary):
	print("Connected to DiscordRPC")
	_init_presence()
	
	
	
func _init_presence():
	var presence = RichPresence.new()
	# Initial Presence Details
	presence.details = "Playing CorruptWeb"
	#presence.state = "Playing Find Em!"#"Project: %s" % ProjectSettings.get_setting("application/config/name")
	presence.start_timestamp = OS.get_unix_time()
	presence.large_image_key = "discordrplogo"
	rpc.get_module("RichPresence").update_presence(presence)
	#setup_party(3, 81221)
	#setup_party(5, 4096)
	
func update_presence(text):
	var presence = RichPresence.new()
	# Initial Presence Details
	presence.first_button = RichPresenceButton.new("Play CorruptWeb", "https://www.google.com")
	presence.details = str(text)
	presence.start_timestamp = OS.get_unix_time()
	presence.large_image_key = "discordrplogo"
	rpc.get_module("RichPresence").update_presence(presence)
	


func setup_party(size, id):
#	var presence = RichPresence.new()
#	presence.party_id = str(id)
#	presence.party_max = 12
#	presence.party_size = int(size)
#	presence.join_secret = "Join_SecretTest"
#	presence.details = "In a Game Lobby"
#	rpc.get_module("RichPresence").update_presence(presence)
#	print("Party Setup")
	pass
	
func _activity_join():
	print("Test")
