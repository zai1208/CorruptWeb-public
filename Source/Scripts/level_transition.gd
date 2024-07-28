extends Control


onready var Vbox = $VBoxContainer
onready var text_place = 0
onready var textsToShow = ["Loading Game Assets...", "Optimizing Game...", "Hacking into the Main Frame..."]
onready var ableToContinue = true
onready var lines = []
onready var line_load_stage = 0
onready var tex
onready var back_checked = false
var MainMenuScene = LoadAssets.get_asset("MainMenu")
func _ready():
	pass




func add_line(text):
	if lines.size() == 0:
		var la = Label.new()
		la.text = str(text)
		Vbox.add_child(la)
		lines.append(la)
		print(lines)
		tex = text
	else:
		tex = text

func _on_Timer_timeout():
	if ableToContinue == true and text_place < textsToShow.size() and LoadAssets.loaded == true:
		add_line(textsToShow[int(text_place)])
		text_place += 1
		$Timer2.start()
		ableToContinue = false
		print(lines[0].text)
		line_load_stage += 1
	
func _on_Timer2_timeout():
	#add_line("RES: [ OK ]")
	ableToContinue = true

func _on_UpdateLoadingScroll_timeout():
	if LoadAssets.loaded == true:
		if line_load_stage == 1:
			lines[0].text = tex + " \\"
			line_load_stage += 1
		elif line_load_stage == 2:
			lines[0].text = tex + " |"
			line_load_stage += 1
			
		elif line_load_stage == 3:
			lines[0].text = tex + " /"
			line_load_stage += 1
			
		elif line_load_stage == 4:
			lines[0].text = tex + " ―"
			line_load_stage += 1
			
		elif line_load_stage == 5:
			lines[0].text = tex + " |"
			line_load_stage += 1
			
		elif line_load_stage == 6:
			lines[0].text = tex + " /"
			line_load_stage += 1
			
		elif line_load_stage == 7:
			lines[0].text = tex + " ―"
			line_load_stage = 1

func _on_FinishCheck_timeout():
	if LoadAssets.loaded == true and back_checked == true:
		SceneManager.change_scene("main_menu")
		print("Checked if game load finished!")


func _on_BackCheck_timeout():
	if LoadAssets.loaded == true:
		back_checked = true 
	else:
		$BackCheck.wait_time = 5.5
		$Timer2.wait_time = 4
