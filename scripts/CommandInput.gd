extends CanvasLayer

signal line_entered

func _ready():
	$Panel/CommandInput.grab_focus()


func _on_CommandInput_text_entered(new_text):
	emit_signal("line_entered", new_text)
