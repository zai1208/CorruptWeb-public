extends Control


onready var LevelManager = get_parent()
onready var LevelVBox = $ScrollContainer/VBoxContainer
export var Base_LevelImageSize = [350, 200]
export var Base_textBoxsize = [353, 174]
export var Base_textBoxpos = [228]


func _ready():
	#Testing
	#var g = LevelManager.get_data("Name", "Level1")
	#print(g)
	#Testing
	add_level("Level 1: The Start", "res://Source/Images/image_placeholder.jpg", "null :)")
	add_level("Level 2: So much chaos!", "res://Source/Images/image_placeholder.jpg", "null :)")
	add_level("Level 3: The end of this mission, the start of another", "res://Source/Images/image_placeholder.jpg", "null :)")
	add_level("Level 4: Mission Failed?", "res://Source/Images/image_placeholder.jpg", "null :)")
	add_level("Level 5: Terror", "res://Source/Images/image_placeholder.jpg", "null :)")
	
func add_level(level_name, level_image, level_resource):
	var cont = Control.new()
	cont.connect("mouse_entered", self, "_mouse_hover_over", [cont])
	LevelVBox.add_child(cont)
	cont.rect_min_size.x = 100
	cont.rect_min_size.y = 100
	var img = TextureRect.new()
	var load_image = load(level_image)
	img.texture = load_image
	cont.add_child(img)
	var text_box = RichTextLabel.new()
	text_box.rect_size.x = Base_textBoxsize[0]
	text_box.rect_size.y = Base_textBoxsize[1]
	img.add_child(text_box)
	text_box.rect_position.x = Base_textBoxpos[0]
	text_box.text = str(level_name) #
	
	
	
	
func _mouse_hover_over(control_node):
	print(control_node.name)

