extends CanvasLayer

signal line_entered

func _ready():
	$Panel/CommandInput.grab_focus()

func _process(delta):
	var time = snapped(get_parent().time,0.01)
	$Panel/Label.text = "Time: " + str(time)

func _on_CommandInput_text_entered(new_text):
	if new_text == "exit":
		Global.goto_scene("res://scenes/menu.tscn")
	else:
		SignalBus.emit_signal("LineEntered", new_text)
