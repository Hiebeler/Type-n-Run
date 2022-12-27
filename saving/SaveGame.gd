extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _ready():
	var dir := Directory.new()
	dir.remove(SAVE_FILE)
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	print(file.get_as_text())
	file.close()

func add_level(level):
	var levels = game_data.levels
	levels.append(levelToDictionary(level))
	game_data.levels = levels
	save_data()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		print("file not exists")
		var level1 = LevelModel.new()
		level1.id = 1
		game_data = {"levels": [levelToDictionary(level1)]}

		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()

func getLevels():
	var levels = []
	for dictlevel in game_data.levels:
		levels.append(dictionaryToLevel(dictlevel))
	return levels

func levelToDictionary(level) -> Dictionary:
	var save_dict = {
		"level_id": level.id,
		"level_completed": level.completed
	}
	return save_dict

func dictionaryToLevel(dictLevel) -> LevelModel:
	var level = LevelModel.new()
	level.id = dictLevel.level_id
	level.completed = dictLevel.level_completed
	return level
