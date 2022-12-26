extends Control

func startLevel(level):
	Global.goto_scene("res://scenes/levels/Level" + level + ".tscn")
