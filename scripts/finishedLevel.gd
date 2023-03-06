extends Control

func init(gameData):
	$LevelText.text = "Level " + gameData.level
	$TimeText.text = "Time: " + str(snapped(gameData.time,0.01))
	$TimeRecord.text = "Highscore: " + str(snapped(SaveGame.getLevel(int(gameData.level)).time, 0.01))

func _on_Menu_pressed():
	Global.goto_scene("res://scenes/menu.tscn")
