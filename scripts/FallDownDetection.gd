extends Area2D

func _on_FallDownDetection_body_entered(body):
	if body.name == "steve":
		get_tree().reload_current_scene()
