extends Control


onready var StartingCutsceneFirstText = true
onready var AbleToControl = false
onready var ControlStage = "None"
func _ready():
	pass 


func _process(delta):
	if StartingCutsceneFirstText == true:
		$Start_Label.visible_characters += 1
		if $Start_Label.visible_characters == 75:
			StartingCutsceneFirstText = false
			$Timer1.start()

func _on_Timer1_timeout():
	load_computerList()
	
	
	
func load_computerList():
	$Label2.set_text("LOADING P2P COMPUTER LIST [PLEASE WAIT]")
	$Label2.visible = true
	$Timer2.start()


func _on_Timer2_timeout():
	$Label2.visible = false
	$Label2.set_text("COMPUTER_09383")
	$Label2.visible = true
	$Label3.visible = true
	$Label4.visible = true
	ControlStage = "ComputerSelect"
	$Timer3.start()

func _input(event):
	if event.is_action_pressed("ui_accept") and AbleToControl == true and ControlStage == "ComputerSelect":
		$Label2.set_text("COMPUTER_09383 [SELECTED/LOADING CHAT]")
		$Timer4.start()

func _on_Timer3_timeout():
	AbleToControl = true
	$Label2.set_text("COMPUTER_09383 [PRESS ENTER TO SELECT]")

func _on_Timer4_timeout():
	$".".visible = false
