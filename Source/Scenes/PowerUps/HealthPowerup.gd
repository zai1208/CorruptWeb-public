extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("OnReady")


func _on_HealthIncreasePowerup_area_entered(area):
	if area.name == "PlayerArea":
		#$HealthIncreasePowerup/CollisionShape2D.disabled = true
		#$AnimationPlayer.play("PowerUpCollected")
		pass
		
	if area.name == "DontSpawnArea":
		queue_free()



func collect_powerup():
	$HealthIncreasePowerup/CollisionShape2D.disabled = true
	$AnimationPlayer.play("PowerUpCollected")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "PowerUpCollected":
		queue_free()
