extends KinematicBody2D


var Health = 100
var dead = false


const WALK_FORCE = 200
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1000
const JUMP_SPEED = 430
onready var gravity = 500
var velocity = Vector2()
func _ready():
	pass 
	
	
	
	
	
func Attacked():
	if not Health == 20:
		Health -= 20
		scale.x -= 0.02
		scale.y -= 0.02
		return false
		
	elif Health == 20:
		$CPUParticles2D.emitting = true
		$CollisionShape2D.disabled = true
		$EnemyArea/CollisionShape2D.disabled = true
		$HealthBar.visible = false
		$Light2D.visible = false
		$TextureRect.visible = false
		return true



func _process(delta):
	
	velocity.y += gravity * delta
	if dead == true and $CPUParticles2D.emitting == false:
		queue_free()
		
		
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
		
func _on_Area2D_area_entered(area):
	pass # Replace with function body.
