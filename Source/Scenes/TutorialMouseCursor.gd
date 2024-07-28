extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	
	
	
func _physics_process(delta):
	$MeshInstance2D.global_position = get_global_mouse_position()



func _process(delta):
	$MeshInstance2D.global_position = get_global_mouse_position()

