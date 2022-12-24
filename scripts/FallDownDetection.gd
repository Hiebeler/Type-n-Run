extends Area2D

onready var body = get_tree().get_root().find_node("steve", true, false)

func _physics_process(delta):
	if overlaps_body(body):
		get_tree().reload_current_scene()
