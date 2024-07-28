extends KinematicBody2D


var WALK_FORCE = 200
var WALK_MAX_SPEED = 200
var STOP_FORCE = 1000
var JUMP_SPEED = 430
onready var gravity = 500
var velocity = Vector2()
var LockedEnemy = null
var RequiredData = 3000
var CollectedData = 0
var Health = 100
var InvertedControls = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/PlayerHUD/GainedData/DataCollected.set_text("Data Collected: " + str(CollectedData) + "MB/" + str(RequiredData) + "MB" )
	HealthCheck()


func _physics_process(delta):
	if InvertedControls == false:
		var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
		if abs(walk) < WALK_FORCE * 0.2:
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		else:
				
			velocity.x += walk * delta
			
		velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
		
		velocity.y += gravity * delta
		velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

		if is_on_floor() and Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_SPEED
	else:
		
		var walk = WALK_FORCE * (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"))
		if abs(walk) < WALK_FORCE * 0.2:
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		else:
				
					
			velocity.x += walk * delta
		velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

		velocity.y += gravity * delta

		velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

		if is_on_floor() and Input.is_action_just_pressed("ui_down"):
			velocity.y = -JUMP_SPEED
		

func _on_Mouse_area_entered(area):
	if area.name == "EnemyArea":
		LockedEnemy = area.get_parent()
		print("Enemy Area")



func _input(event):
	if event.is_action_pressed("LeftMouseClick") or event.is_action_pressed("SpaceBar"):
		if not LockedEnemy == null:
			var em = LockedEnemy.Attacked()
			$Attack.play()
			
			if em == true:
				$EnemyDestroyed.play()
				$Camera2D.trauma = 0.6
				CollectedData += 500
				$Camera2D/PlayerHUD/GainedData/DataCollected.set_text("Data Collected: " + str(CollectedData) + "MB/" + str(RequiredData) + "MB" )
			if em == false:
				$Camera2D.trauma = 0.25


func _on_Mouse_area_exited(area):
	if area.name == "EnemyArea":
		LockedEnemy = null


func _on_PlayerArea_area_entered(area):
	if area.name == "ShowDataCollectedArea":
		$Camera2D/PlayerHUD/GainedData/DataCollected.visible = true
		
	if area.name == "DecreaseHealth":
		if not Health == 20:
			Health -= 20
			HealthCheck()
			
	if area.name == "RestoreHealth":
		Health = 100
		InvertedControls = false
		WALK_MAX_SPEED = 200
		WALK_FORCE = 200
		HealthCheck()
		
	if area.name == "CorruptionEffects":
		InvertedControls = true
		
	if area.name == "JumpPad":
		velocity.y = -JUMP_SPEED * 1.6
		

func HealthCheck():
	if Health == 100:
		$ShakeGlitchEffect.material.set_shader_param("shake_rate", 0)
		$HealthBar.value = 100
		WALK_FORCE = 200
		WALK_MAX_SPEED = 200
	elif Health == 80:
		$ShakeGlitchEffect.material.set_shader_param("shake_rate", 0.058)
		$HealthBar.value = 80
		WALK_FORCE = 185
		WALK_MAX_SPEED = 185
	elif Health == 60:
		$ShakeGlitchEffect.material.set_shader_param("shake_rate", 0.11)
		$HealthBar.value = 60
		WALK_FORCE = 160
		WALK_MAX_SPEED = 160
	elif Health == 40:
		InvertedControls = true
		WALK_MAX_SPEED = 130
		WALK_FORCE = 130
		$ShakeGlitchEffect.material.set_shader_param("shake_rate", 0.16)
		$HealthBar.value = 40
		
		
		
func _on_PlayerArea_area_exited(area):
	if area.name == "ShowDataCollectedArea":
		$Camera2D/PlayerHUD/GainedData/DataCollected.visible = false


func _on_DecreaseHealth_area_entered(area):
	pass # Replace with function body.
