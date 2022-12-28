extends Area2D

func _on_Finish_body_entered(body):
	if body.name == "steve":
		var level = get_tree().get_current_scene().get_name()
		var levelIndex = level.substr(level.length() - 1)
		
		SignalBus.emit_signal("FinishedLevel")
		var time = get_parent().time
		
		SaveGame.add_level(createLevelModel(int(levelIndex) + 1))
		Global.goto_scene("res://scenes/finishedLevel.tscn", {"level": levelIndex, "time": time})

func createLevelModel(levelIndex) -> LevelModel:
		var level = LevelModel.new()
		level.id = levelIndex
		return level
