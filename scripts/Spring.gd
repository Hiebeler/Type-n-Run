extends Area2D

func _on_Spring_body_entered(body):
	if body.name == "steve":
		SignalBus.emit_signal("SpringEntered")
