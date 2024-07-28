extends Spatial

#Note: Globe auto rotation has been disabled for manual mouse moving globe effect
onready var mouse_enteredGlobe = false
onready var mouse_clickGlobe = false
onready var mouseSpinGlobeStarted = false
onready var mouseSpinGlobeTimer = false
onready var SelectedContinent = "Africa"
onready var GlobeRotateToMission = false
onready var GlobeRotatetoPosition = null
onready var MissionDatabase = {
	"Africa" : {
		"Computer_078162" : {"EarthPosition" : Vector3(-1, -11, 0), "MissionInfomation" : "This Computer has been infected by the worm, Stop the Worm."},
		"Computer_087376" : {"EarthPosition" : Vector3(9, -23.45, 0), "MissionInfomation" : "This Computer has been infected by the worm, Stop the Worm."},
		"Computer_017262" : {"EarthPosition" : Vector3(4, -12.0, 0), "MissionInfomation" : "This Computer has been infected by the worm, Stop the Worm."},
		"Computer_052312" : {"EarthPosition" : Vector3(6, -22.0, 0), "MissionInfomation" : "This Computer has been infected by the worm, Stop the Worm."}
		},
	"Asia" : {},
	"Australia": {},
	"North America": {},
	"South America" : {},
	"Europe" : {}

}

func _ready():
	$AnimationPlayer.play("globe_into") 
	$AnimationPlayer3.play_backwards("globe_scaleUp")
	for i in MissionDatabase[str(SelectedContinent)]:
		var button = Button.new()
		button.set("custom_styles/normal", StyleBoxEmpty.new())
		button.text = str(i)
		$UI/MissionList/VBoxContainer.add_child(button)
		button.add_to_group("MissionButtons")
		
	$UI/MissionListContinent.set_text("MISSIONS: " + SelectedContinent)
	var b = get_tree().get_nodes_in_group("MissionButtons")
	for g in b:
		g.connect("pressed", self, "_mission_button_pressed", [g.text])
	$MeshInstance.rotation_degrees.x = 0
	$MeshInstance.rotation_degrees.y = 0
	#$MeshInstance.rotation_degrees.z = 0
		
func _on_Area_mouse_entered():
	#$AnimationPlayer3.play("globe_scaleUp")
	mouse_enteredGlobe = true


func _on_Area_mouse_exited():
	#$AnimationPlayer3.play_backwards("globe_scaleUp")
	mouse_enteredGlobe = false
	
func _input(event):
	if event.is_action_pressed("LeftMouseClick") and mouse_enteredGlobe == true:
		mouse_clickGlobe = true
		#$AnimationPlayer2.stop(false)
	if event.is_action_released("LeftMouseClick"):
		mouse_clickGlobe = false
		if mouse_enteredGlobe == true:
			#$MeshInstance.rotate_object_local(Vector3.UP, 20)
			mouseSpinGlobeTimer = true
			$GlobeSpinTimer.start()
		#if mouse_clickGlobe == true and mouse_enteredGlobe == true and mouseSpinGlobeStarted == true:
			#mouse_clickGlobe = false
		#$AnimationPlayer2.play("globe_rotation")
		GlobeclickLetGo(event.position.x, event.position.y)
#	if InputEventMouseMotion and mouseSpinGlobeStarted == false:
#		if mouse_clickGlobe == true and mouse_enteredGlobe == true:
#			mouseSpinGlobe(event.position.x, event.position.y)
#			mouseSpinGlobeStarted = true
		#if mouse_clickGlobe == true and mouse_enteredGlobe == true and mouseSpinGlobeStarted = true:
			
	if InputEventMouseMotion:
		if mouse_enteredGlobe == true and mouse_clickGlobe == true:
			if event is InputEventMouseMotion: 
				$MeshInstance.rotate_object_local(Vector3.UP, event.relative.x / 400)
				$MeshInstance.rotate_object_local(Vector3.LEFT, event.relative.y / 400) #Breaks Globe Rotation for Y axis, so uh yeah 
			
func mouseSpinGlobe(mouse_posX, mouse_posY):
	pass

func GlobeclickLetGo(mouse_posX, mouse_posY):
	pass
	
func CalculateGlobeSpin():
	pass

func _physics_process(delta):
			
	if GlobeRotateToMission == true:
		
		print($MeshInstance.rotation_degrees)
		print(GlobeRotatetoPosition)
		if GlobeRotatetoPosition.x - 0.000001 > $MeshInstance.rotation_degrees.x or GlobeRotatetoPosition.y - 0.000001 > $MeshInstance.rotation_degrees.y or GlobeRotatetoPosition.z - 0.000001 > $MeshInstance.rotation_degrees.z:
			GlobeRotateToMission = false
			GlobeRotatetoPosition = null
			print("Stopped Rotation")
			
				
		if not GlobeRotatetoPosition == null:
			print($MeshInstance.rotation_degrees)
			if not GlobeRotatetoPosition.x == $MeshInstance.rotation_degrees.x:
				if GlobeRotatetoPosition.x > $MeshInstance.rotation_degrees.x:
					$MeshInstance.rotation_degrees.x += 1
				if GlobeRotatetoPosition.x < $MeshInstance.rotation_degrees.x:
					$MeshInstance.rotation_degrees.x -= 1
					
			if not GlobeRotatetoPosition.y == $MeshInstance.rotation_degrees.y:
				if GlobeRotatetoPosition.y > $MeshInstance.rotation_degrees.y:
					$MeshInstance.rotation_degrees.y += 1
				if GlobeRotatetoPosition.y < $MeshInstance.rotation_degrees.y:
					$MeshInstance.rotation_degrees.y -= 1

			if not GlobeRotatetoPosition.z == $MeshInstance.rotation_degrees.z:
				if GlobeRotatetoPosition.z > $MeshInstance.rotation_degrees.z :
					$MeshInstance.rotation_degrees.z += 1
				if GlobeRotatetoPosition.z < $MeshInstance.rotation_degrees.z:
					$MeshInstance.rotation_degrees.z -= 1
			
func _on_GlobeSpinTimer_timeout():
	mouseSpinGlobeTimer = false
	
	
func _mission_button_pressed(button_text):
	if button_text in MissionDatabase[str(SelectedContinent)]:
		#$MeshInstance.rotation_degrees.x = MissionDatabase[str(SelectedContinent)][str(button_text)]["EarthPosition"].x
		#$MeshInstance.rotation_degrees.y = MissionDatabase[str(SelectedContinent)][str(button_text)]["EarthPosition"].y
		#$MeshInstance.rotation_degrees.z = MissionDatabase[str(SelectedContinent)][str(button_text)]["EarthPosition"].z
		GlobeRotatetoPosition = MissionDatabase[str(SelectedContinent)][str(button_text)]["EarthPosition"]
		GlobeRotateToMission = true






