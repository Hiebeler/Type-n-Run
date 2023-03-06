extends Node

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path, gameData = {}):
	call_deferred("_deferred_goto_scene", path, gameData)

func _deferred_goto_scene(path, gameData):
	# It is now safe to remove the current scene
	current_scene.free()

	var newScene = ResourceLoader.load(path)
	current_scene = newScene.instantiate()
		
	if gameData.hash() != {}.hash():
		current_scene.init(gameData)

	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
