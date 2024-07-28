extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if LevelGenerationData.GAME_MODE == 1:
		pass


func _on_Area2D_area_entered(area):
	if area.name == "PlayerName" and LevelGenerationData.GAME_MODE == 1:
		spawn_enemy()
		
		
func spawn_enemy():
	#var em = preload("res://Source/Scenes/Enemy-01.tscn").instance()
	#em.position = self.position
	#get_parent().get_node("Enemys").add_child(em)
	#get_parent().reload_EnemyCollison(em)
	#get_parent().MinDestoryedEnemyNumber += 1
	pass
	


func _on_EnemyAreaWaittime_timeout():
	spawn_enemy()


func _on_Timer_timeout():
	if LevelGenerationData.GAME_MODE == 1:
		spawn_enemy()
		
