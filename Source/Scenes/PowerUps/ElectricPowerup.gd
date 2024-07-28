extends Node2D







func _ready():
	pass 




func collect_powerup():
	$AnimationPlayer.play("ElectricPowerUpCollect")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ElectricPowerUpCollect":
		queue_free()
		
	


func _on_ElectricPowerup_area_entered(area):
	if area.name == "DontSpawnArea":
		queue_free()
	
	
	
	
