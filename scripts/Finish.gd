extends Area2D

onready var body = get_tree().get_root().find_node("steve", true, false)

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if overlaps_body(body):
		var level = get_tree().get_current_scene().get_name()
		Global.goto_scene("res://scenes/finishedLevel.tscn", {"level": level.substr(level.length() - 1)})
