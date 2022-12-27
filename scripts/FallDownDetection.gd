extends Area2D

func _on_FallDownDetection_body_entered(body):
	if body.name == "steve":
		var sceneName = get_tree().get_current_scene().get_name()

		Global.goto_scene("res://scenes/levels/" + sceneName + ".tscn")
