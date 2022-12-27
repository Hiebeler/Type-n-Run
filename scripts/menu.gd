extends Control

func _ready():
	var levels = SaveGame.getLevels()
	for level in levels:
		print(level.id)
		var levelName = "Level" + str(level.id)
		var levelButton = get_node(levelName)
		levelButton.disabled = false
		print(levelName)

func startLevel(level_id):
	#SaveGame.addLevel(createLevelModel(level_id))
	Global.goto_scene("res://scenes/levels/Level" + level_id + ".tscn")

func createLevelModel(level_id) -> LevelModel:
		var level = LevelModel.new()
		level.id = level_id
		return level
