extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _ready():
	#var dir = Directory.new()
	#dir.remove(SAVE_FILE)
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func add_level(level):
	var levels = game_data.levels
	if not LevelIsAreadyStored(level):
		levels.append(levelToDictionary(level))
		game_data.levels = levels
		save_data()

func LevelIsAreadyStored(levelToAdd) -> bool:
	for level in game_data.levels:
		if (level.level_id == levelToAdd.id):
			return true
	return false

func update_level(levelToUpdate):
	var updatedLevels = []
	print(levelToDictionary(levelToUpdate))
	for level in game_data.levels:
		if level.level_id == levelToUpdate.id and (level.level_time > levelToUpdate.time or level.level_time == 0):
			updatedLevels.append(levelToDictionary(levelToUpdate))
		else:
			updatedLevels.append(level)
	game_data.levels = updatedLevels
	print(updatedLevels)
	save_data()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		createDefaultSet()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	print(game_data)
	file.close()

func createDefaultSet():
	var level = LevelModel.new()
	level.id = 1
	game_data = {"levels": [levelToDictionary(level)]}
	save_data()

func getLevels():
	var levels = []
	for dictlevel in game_data.levels:
		levels.append(dictionaryToLevel(dictlevel))
	return levels

func getLevel(id):
	for dictLevel in game_data.levels:
		if dictLevel.level_id == id:
			return dictionaryToLevel(dictLevel)
	return null

func levelToDictionary(level) -> Dictionary:
	var save_dict = {
		"level_id": level.id,
		"level_completed": level.completed,
		"level_time": level.time
	}
	return save_dict

func dictionaryToLevel(dictLevel) -> LevelModel:
	var level = LevelModel.new()
	level.id = dictLevel.level_id
	level.completed = dictLevel.level_completed
	level.time = dictLevel.level_time
	return level
