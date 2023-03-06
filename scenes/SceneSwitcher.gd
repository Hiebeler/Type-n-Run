extends Node

@onready var current_level = $Menu

func _ready():
	current_level.connect("level_changed",Callable(self,"handle_level_changed"))

func handle_level_changed(current_level_index: String):
	print(current_level_index)
	var next_level
	if current_level_index == "0":
		next_level = load("res://scenes/Menu.tscn").instantiate()
	else :
		next_level = load("res://scenes/levels/level" + current_level_index + ".tscn").instantiate()
	add_child(next_level)
	next_level.connect("level_changed",Callable(self,"handle_level_changed"))
	current_level.queue_free()
	current_level = next_level
	
