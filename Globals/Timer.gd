extends Node

var timer = Timer.new()

signal pulse

func _ready():
	add_child(timer)
	timer.autostart = true
	timer.connect("timeout",pulseemit)
	timer.start(0.75)

func pulseemit():
	emit_signal("pulse")
