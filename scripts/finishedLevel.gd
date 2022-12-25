extends Control

func _ready():
	pass

func test(gameData):
	$Label.text = "Level " + gameData.level

func _on_Menu_pressed():
	Global.goto_scene("res://scenes/menu.tscn")
	
