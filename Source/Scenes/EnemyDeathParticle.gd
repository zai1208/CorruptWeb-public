extends KinematicBody2D


const WALK_FORCE = 200
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1000
const JUMP_SPEED = 430
var velocity = Vector2()
onready var gravity = 500
func _ready():
	velocity.x += 0.25
	velocity.x -= 0.01

func _physics_process(delta):
	
	velocity.y += gravity * delta
	
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
