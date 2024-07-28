extends Control







export var LevelSizeX = 200
export var LevelSizeY = 400
export var Difficulty = 1 # 1: Easy, 2: Normal, 3: Hard
export var EnemyArray = []
export var EndComputerPos = []
export var PlatformArray = []
var WallPlacement_x = []
var WallPlacement_y = []
var gen_mode = "Straight" #Straight, Up, Down
var prev_value_x = 30
var prev_value_y = 30
var tile_map = get_parent()
var WallPreset = preload("res://Source/Scenes/TestWall.tscn")
var rng = RandomNumberGenerator.new()
func _ready():
	$Timer.start()
	#test 
	#rng.randomize()
	#var num = rng.randi_range(25, 205)
	#var num_2 = rng.randi_range(25, 205)
	#spawnWall(num, num_2)
	
func generateLevel(enemys, platforms, level_difficulty, endPos):
	
	pass
	
	
func _physics_process(delta):
	if gen_mode == "Straight":
		rng.randomize()
		var num = rng.randi_range(25, 205)
		var num_2 = rng.randi_range(25, 205)
		spawnWall(prev_value_x + 10, prev_value_y)
		WallPlacement_x.append(prev_value_x + 10)
		WallPlacement_y.append(prev_value_y)
		prev_value_x = prev_value_x + 10
	elif gen_mode == "Down":
		spawnWall(prev_value_x, prev_value_y - 10)
		WallPlacement_y.append(prev_value_y)
		prev_value_y = prev_value_y - 10
		

func spawnWall(x, y):
	var wall = WallPreset.instance()
	wall.position.x = x
	wall.position.y = y
	add_child(wall)
	wall.position.x = x
	wall.position.y = y





func _on_Timer_timeout():
	gen_mode = "Down"
