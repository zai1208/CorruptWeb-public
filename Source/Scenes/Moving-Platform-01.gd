extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_traverse_length = 100
var traverse_x = 0
var forward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if traverse_x == 0:
		forward = true
	if traverse_x < max_traverse_length && forward == true:
		self.position.x += 1
		traverse_x += 1
	if traverse_x == max_traverse_length:
		forward = false
	if traverse_x > 0 && forward == false:
		self.position.x -= 1
		traverse_x -= 1
