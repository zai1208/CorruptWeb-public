extends KinematicBody2D

var WALK_FORCE = 200
var WALK_MAX_SPEED = 200
var STOP_FORCE = 1000
var JUMP_SPEED = 430
var Health = 100
var velocity = Vector2()
var EnemyAreaNameArray = ["Enemy-01"]
onready var gravity = 500
var LockedEnemy
var OnEnemy = false
var EnemyDestroyingPlayer = false
var ControlsDisabed = false
var Resetting = false
var screen_shaking = false
var InvertedControls = false
var speed_boosted = false
var PurposePause = false
var PushOutPowerupCollectedNum = 0
func _ready():
	$AnimationPlayer.play("PlayerDeathReadyReset")
	HealthDecreased()
	
func _physics_process(delta):
	if Global.PlayingMultiplayer == true:
		rpc_unreliable("update_player_pos", global_position, get_tree().get_network_unique_id()) #Peer id 1 is the master/server
		
	if ControlsDisabed == false:
		if InvertedControls == false:
			
			# Horizontal movement code. First, get the player's input.
			var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
			# Slow down the player if they're not trying to move.
			if abs(walk) < WALK_FORCE * 0.2:
				# The velocity, slowed down a bit, and then reassigned.
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
			else:
				
					
				velocity.x += walk * delta
			# Clamp to the maximum horizontal movement speed.
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

			# Vertical movement code. Apply gravity.
			velocity.y += gravity * delta

			# Move based on the velocity and snap to the ground.
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			# Check for jumping. is_on_floor() must be called after movement code.
			if is_on_floor() and Input.is_action_just_pressed("ui_up"):
				velocity.y = -JUMP_SPEED
				
		elif InvertedControls == true:
			# Horizontal movement code. First, get the player's input.
			var walk = WALK_FORCE * (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"))
			# Slow down the player if they're not trying to move.
			if abs(walk) < WALK_FORCE * 0.2:
				# The velocity, slowed down a bit, and then reassigned.
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
			else:
				
					
				velocity.x += walk * delta
			# Clamp to the maximum horizontal movement speed.
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

			# Vertical movement code. Apply gravity.
			velocity.y += gravity * delta

			# Move based on the velocity and snap to the ground.
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			# Check for jumping. is_on_floor() must be called after movement code.
			if is_on_floor() and Input.is_action_just_pressed("ui_down"):
				velocity.y = -JUMP_SPEED
		
		
		if Input.is_action_pressed("BoostedKeys"):
			if speed_boosted == true:
				$Camera2D.trauma = 0.24
				
				
#		if Input.is_action_just_pressed("LeftMouseClick"):
#			if ControlsDisabed == false:
#				#if OnEnemy == true:
#				if not LockedEnemy == null:
#					var em = LockedEnemy.Attacked()
#					$Attack.play(0)
#					$Camera2D.trauma = 0.25
#					if em == true:
#						get_parent().SpawnedEnemyArray.erase(LockedEnemy)
#						$Camera2D.trauma = 0.6
#						var random = RandomNumberGenerator.new()
#						random.randomize()
#						var random_pitch = random.randf_range(0.5, 1.1)
#						$EnemyDestroyed.pitch_scale = random_pitch
#						$EnemyDestroyed.play()
#						get_parent().CollectedData += 500
#						get_parent().DestroyedEnemyNumber += 1
#						get_parent().checkEnemyNumberReached()
#						get_parent().refreshData_collected()
						
						
			if speed_boosted == true:
				WALK_FORCE = 200 * 1.8
				JUMP_SPEED = 430 
				WALK_MAX_SPEED = 600
			
		

func _on_Area2D_area_entered(area):
	if area.name in EnemyAreaNameArray:
		print("Enemy Attacked player")
		if not Health == null:
			$HealthDecreaseTimer.start()
			$ShakeGlitchEffect.visible = true
			Health -= 20
			$HealthBar.value = int(Health)
			HealthDecreased()
			
	if area.name == "JumpPad":
		JumpPadBoost()
		
	if area.name == "HealthIncreasePowerup":
		if not Health == 100:
			area.get_parent().collect_powerup()
			IncreaseHealth(20)
			$Powerup.play(0)
			
	if area.name == "ElectricPowerup":
		area.get_parent().collect_powerup()
		WALK_FORCE = 200 * 1.8
		JUMP_SPEED = 430 
		WALK_MAX_SPEED = 600
		$Powerup.play(0)
		$SpeedPowerUpEffectTimer.start()
		$SpeedGhostEffect.emitting = true
		speed_boosted = true
		
		
	if area.name == "PushOutPowerUp":
		PushOutPowerupCollectedNum += 1
		
		
func IncreaseHealth(amount):
	Health += int(amount)
	$HealthBar.value = int(Health)
	HealthDecreased()
	
func JumpPadBoost():
	velocity.y = -JUMP_SPEED * 1.8
	
	
func _on_CursorObjectArea_area_entered(area):
	if area.name in EnemyAreaNameArray:
		LockedEnemy = area.get_parent()
		OnEnemy = true
		area.get_parent().show_healthBar()
		print("OnEnemy")
		

func _on_CursorObjectArea_area_exited(area):
	if area.name == "Enemy-01":
		area.get_parent().hide_healthBar()
		OnEnemy = false
		LockedEnemy = null
		print("Enemy Left Cursor")
	
	
func _input(event):
	if event.is_action_pressed("LeftMouseClick") or event.is_action_pressed("SpaceBar"):
		if ControlsDisabed == false:
			if not LockedEnemy == null:
				var em = LockedEnemy.Attacked()
				$Attack.play(0)
				$Camera2D.trauma = 0.25
				if em == true:
					get_parent().SpawnedEnemyArray.erase(LockedEnemy)
					$Camera2D.trauma = 0.6
					var random = RandomNumberGenerator.new()
					random.randomize()
					var random_pitch = random.randf_range(0.5, 1.1)
					$EnemyDestroyed.pitch_scale = random_pitch
					$EnemyDestroyed.play()
					get_parent().CollectedData += 500
					get_parent().DestroyedEnemyNumber += 1
					get_parent().checkEnemyNumberReached()
					get_parent().refreshData_collected()
						
						
		if event.is_action_pressed("E"):
			if not PushOutPowerupCollectedNum == 0:
				pass
					
func RemoveHealth(amount):
	Health -= int(amount)
	$HealthBar.value = int(Health)
	HealthDecreased()
	$AttackedAnim.play("cooldown_Attack")
func _on_HealthDecreaseTimer_timeout():
	Health -= 20
	$HealthBar.value = int(Health)
	HealthDecreased()

func _on_PlayerArea_area_exited(area):
	if area.name in EnemyAreaNameArray:
		print("Enemy Left Player")
		if not Health == null:
			$HealthDecreaseTimer.stop()
			$ShakeGlitchEffect.visible = false



func HealthDecreased():
	print(Health)
	if Health == 100:
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0)
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_power", 0.05)
		get_parent().get_node("AudioEffects/AnimationPlayer").play("Upto100Health")
		InvertedControls = false
		WALK_FORCE = 200
		WALK_MAX_SPEED = 200
	if Health == 80:
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0.058)
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_power", 0.05)
		get_parent().get_node("AudioEffects/AnimationPlayer").play("Downto80Health")
		print("Changed Shake Rate")
		InvertedControls = false
		WALK_FORCE = 185
		WALK_MAX_SPEED = 185
	elif Health == 60:
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0.11)
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_power", 0.05)
		get_parent().get_node("AudioEffects/AnimationPlayer").play("Downto60Health")
		print("Changed Shake Rate")
		InvertedControls = false
		WALK_FORCE = 160
		WALK_MAX_SPEED = 160
	elif Health == 40:
		InvertedControls = true
		WALK_FORCE = 130
		WALK_MAX_SPEED = 130
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0.16)
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_power", 0.05)
		get_parent().get_node("AudioEffects/AnimationPlayer").play("Downto40Health")
		print("Changed Shake Rate")
	elif Health == 20:
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0.30)
		$ShakeGlitchHealthEffect.material.set_shader_param("shake_power", 0.05)
		get_parent().get_node("AudioEffects/AnimationPlayer").play("Downto20Health")
		print("Changed Shake Rate")
	elif Health == 0:
		_die()



func _die():
	ControlsDisabed = true
	get_parent().get_node("BGMusic").stop()
	$AnimationPlayer.play("PlayerDeathAnimation")
	PurposePause = true

func reset():
	$ShakeGlitchHealthEffect.material.set_shader_param("shake_rate", 0)
	Health = 100
	HealthDecreased()
	$HealthBar.value = int(Health)
	$AnimationPlayer.play("PlayerDeathReadyReset")
	position = get_parent().get_node("PlayerStartGamePos").position
	get_parent().get_node("BGMusic").play()
	PurposePause = false
	Health = 100
	Health = 100
	Health = 100
	Health = 100
	Health = 100
	HealthDecreased()

func _on_LevelBoundary_area_entered(area):
	if area.name == "PlayerArea":
		position = get_parent().get_node("PlayerStartGamePos").position




remote func update_player_pos(pos, id):
	if get_parent().has_node(str(id)):
		get_parent().get_node(str(id)).global_position = pos




func _on_SpeedPowerUpEffectTimer_timeout():
	WALK_FORCE = 200 
	JUMP_SPEED = 430 
	WALK_MAX_SPEED = 200
	$SpeedGhostEffect.emitting = false
	speed_boosted = false


func _on_EnemySpawnFix_area_entered(area):
	var velocity_num = velocity.y
	velocity.y = velocity_num + 20


func _on_CursorObjectArea_body_entered(body):
	if body.name == "Enemy":
		LockedEnemy = body
		OnEnemy = true


func _on_CursorObjectArea_body_exited(body):
	if body.name == "Enemy":
		LockedEnemy = false
		OnEnemy = true
