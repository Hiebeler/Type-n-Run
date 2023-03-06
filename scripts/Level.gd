extends Node2D

var time = 0
var timer_running = false

func _ready():
	SignalBus.connect("LineEntered",Callable(self,"lineEntered"))
	SignalBus.connect("FinishedLevel",Callable(self,"finishedLevel"))

func _process(delta):
	if timer_running:
		time += delta

func lineEntered(input):
	print("start")
	timer_running = true

func finishedLevel():
	timer_running = false
