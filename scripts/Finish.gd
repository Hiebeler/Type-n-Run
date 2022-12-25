extends Area2D

onready var body = get_tree().get_root().find_node("steve", true, false)

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if overlaps_body(body):
		print("finish")
		Global.goto_scene("res://scenes/finishedLevel.tscn")
