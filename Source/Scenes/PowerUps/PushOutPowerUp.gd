extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func collect_powerup():
	queue_free()


func _on_PushOutPowerUp_area_entered(area):
	if area.name == "DontSpawnArea":
		queue_free()
