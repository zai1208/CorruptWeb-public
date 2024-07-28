extends Node




onready var core_count
onready var ram_usage
func _ready():
	core_count = OS.get_processor_count()
	ram_usage = OS.get_static_memory_usage()
	print(ram_usage)


func _process(delta):
	ram_usage = OS.get_static_memory_usage()
