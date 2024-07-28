extends KinematicBody2D





const WALK_FORCE = 200
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1000
const JUMP_SPEED = 430
var Idle = true
var MovementDirection = "Right"
var velocity = Vector2()
onready var gravity = 500
onready var random_number
var MovingToPlayer = false 
var PlayerTarget 
var AttemptsTillDeath = 10
var Health = 100
var Moving = true
var Dieing = false
func _ready():
	#var random = RandomNumberGenerator.new()
	#random.randomize()
	#random_number = random.randi_range(0, 2)
	#if random_number == 1:
	##	MovementDirection = "Right"
	#elif random_number == 2:
	#	MovementDirection = "Left"
	pass
	
	
func _physics_process(delta):
	if Moving == true:
		if MovementDirection == "Right":
			
			velocity.y += gravity * delta
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
			
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			if Idle == true:
				velocity.x += 0.25
				
				
				
		elif MovementDirection == "Left":
			
			velocity.y += gravity * delta
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
			
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			if Idle == true:
				velocity.x -= 0.25
		#	if random_number == 1:
		#		velocity.x += 0.5
		#	else:
		#		velocity.x -= 0.5
		if MovingToPlayer == true:
			velocity = global_position.direction_to(PlayerTarget.global_position) * WALK_MAX_SPEED
			
			
			
#		if Global.PlayingMultiplayer == true and Global.MultiplayerHost == true:
#			rpc_unreliable("SyncEnemyPos", global_position, name)
		




func _on_MoveTowardsArea_area_entered(area):
	if area.name == "PlayerArea":
		PlayerTarget = area.get_parent()
		MovingToPlayer = true
		


func _on_MoveTowardsArea_area_exited(area):
	if area.name == "PlayerArea":
		MovingToPlayer = false
		PlayerTarget = null


func _on_Enemy01_area_entered(area):
	if area.name == "CursorObjectArea":
		$HealthBar.visible = true
	
	if area.name == "LevelBoundary":
		global_position.x = 2825
		global_position.y = 461

func show_healthBar():
	$HealthBar.visible = true
	
func hide_healthBar():
	$HealthBar.visible = false
	
func Attacked():
	print("Enemy Attacked")
	if not AttemptsTillDeath == 0 or not Health == 0:
		AttemptsTillDeath -= 1
		Health -= 10
		if Health == 0:
			$TextureRect.visible = false
			$CollisionShape2D.disabled = true
			$"Enemy-01/CollisionShape2D2".disabled = true
			$MoveTowardsArea/CollisionShape2D.disabled = true
			$Light2D.visible = false
			$HealthBar.visible = false
			$CPUParticles2D.emitting = true
			Dieing = true
			return true
		else:
			$HealthBar.value = int(Health)
			scale.x -= 0.02
			scale.y -= 0.02
			return false
		
	else:
		if AttemptsTillDeath == 0 and Health == 0 and $HealthBar.value == 0:
			$TextureRect.visible = false
			$CollisionShape2D.disabled = true
			$"Enemy-01/CollisionShape2D2".disabled = true
			$MoveTowardsArea/CollisionShape2D.disabled = true
			$Light2D.visible = false
			$HealthBar.visible = false
			$CPUParticles2D.emitting = true
			Dieing = true
			return true
			
			
	if Health == 0:
		$TextureRect.visible = false
		$CollisionShape2D.disabled = true
		$"Enemy-01/CollisionShape2D2".disabled = true
		$MoveTowardsArea/CollisionShape2D.disabled = true
		$Light2D.visible = false
		$HealthBar.visible = false
		$CPUParticles2D.emitting = true
		Dieing = true
		return true
		
func _process(delta):
	if Dieing == true and $CPUParticles2D.emitting == false:
		_die()

func _on_Enemy01_area_exited(area):
	#if area.name == "CursorObjectArea":
	#	$HealthBar.visible = false
	pass


func _die():
	queue_free()

func MultiplayerDestroy():
	$TextureRect.visible = false
	$CollisionShape2D.disabled = true
	$"Enemy-01/CollisionShape2D2".disabled = true
	$MoveTowardsArea/CollisionShape2D.disabled = true
	$Light2D.visible = false
	$HealthBar.visible = false
	$CPUParticles2D.emitting = true
	Dieing = true


#remote func SyncEnemyPos(pos, em_name):
#	#get_parent().get_parent().UpdateEnemyPos(pos, em_name)
#	global_position = pos


func _on_MovementTimer_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	random_number = random.randi_range(0, 2)
	if random_number == 1:
		MovementDirection = "Right"
	elif random_number == 2:
		MovementDirection = "Left"
