extends Control

func init(gameData):
	$Label.text = "Level " + gameData.level

func _on_Menu_pressed():
	Global.goto_scene("res://scenes/menu.tscn")
	
