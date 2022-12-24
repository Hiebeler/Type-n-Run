extends Control

func startLevel(level):
	get_tree().change_scene("res://scenes/levels/level" + level + ".tscn")
