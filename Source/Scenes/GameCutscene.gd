extends Control







func _ready():
	pass




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Cutscene":
		get_tree().change_scene("res://Source/Scenes/TutorialLevel.tscn")
