extends Area2D

func _on_Finish_body_entered(body):
	if body.name == "steve":
		var level = get_tree().get_current_scene().get_name()
		Global.goto_scene("res://scenes/finishedLevel.tscn", {"level": level.substr(level.length() - 1)})
