extends CanvasLayer

signal line_entered

func _ready():
	$Panel/CommandInput.grab_focus()


func _on_CommandInput_text_entered(new_text):
	if new_text == "exit":
		get_tree().change_scene("res://scenes/menu.tscn")
	else:
		emit_signal("line_entered", new_text)
