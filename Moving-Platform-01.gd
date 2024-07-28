extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_traverse_distance = 100
export var speed = 1
export(String, "horizontal", "vertical") var movement
var traversed_distance = 0
var forward = true
var up = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_number = random.randi_range(0, 3)
	if random_number == 1:
		self.position.x = 10
		traversed_distance = 10
	elif random_number == 2:
		self.position.x = -20
		traversed_distance = -20
	elif random_number == 3:
		self.position.x = -45
		traversed_distance = -45


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == "horizontal":
		if traversed_distance == 0:
			forward = true
		if traversed_distance < max_traverse_distance && forward == true:
			self.position.x += 1
			traversed_distance += 1
		if traversed_distance == max_traverse_distance:
			forward = false
		if traversed_distance> 0 && forward == false:
			self.position.x -= 1
			traversed_distance -= 1
	if movement == "vertical":
		if traversed_distance == 0:
			up = true
		if traversed_distance < max_traverse_distance && up == true:
			self.position.y -= 1
			traversed_distance += 1
		if traversed_distance == max_traverse_distance:
			up = false
		if traversed_distance> 0 && up == false:
			self.position.y += 1
			traversed_distance -= 1
