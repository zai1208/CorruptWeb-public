extends Control






onready var SelfSentMessageTyping = false
onready var MessageTypedText = "None"
onready var LevelSelectorScene = LoadAssets.get_asset("LevelSelectorScene")
func _ready():
	pass






func _on_Timer4_timeout():
	visible = true
	$AnimationPlayer.play("StartingCutsceneChatUI")

func add_new_chatMessage(text):
	var la = Label.new()
	la.set_text("COMPUTER_09383: " + str(text))
	$ScrollContainer/VBoxContainer.add_child(la)
	
func add_selfSentMessage(text):
	SelfSentMessageTyping = true
	$ColorRect/SendMessageLabel.visible_characters = 0
	$ColorRect/SendMessageLabel.set_text(str(text))
	MessageTypedText = str(text)
	SelfSentMessageTyping = true
	#var la = Label.new()
	#la.set_text("YOU:" + str(text))
	#$ScrollContainer/VBoxContainer.add_child(la)
	
	
func MessageTyped(text):
	var la = Label.new()
	la.set_text("YOU: " + str(text))
	$ScrollContainer/VBoxContainer.add_child(la)
	

func _process(delta):
	if SelfSentMessageTyping == true:
		if $ColorRect/SendMessageLabel.visible_characters > 60:
			SelfSentMessageTyping = false
			MessageTyped(str(MessageTypedText))
			MessageTypedText = "None"
		else:
			$ColorRect/SendMessageLabel.visible_characters += 1
	

func end_chatScene():
	$Timer1.start()
	
func _on_Timer1_timeout():
	get_tree().change_scene_to(LevelSelectorScene)
