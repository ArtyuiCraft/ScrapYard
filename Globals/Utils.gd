@tool
extends Node

func string_to_rotation(string: String):
	if string == "up":
		return -90
	if string == "down":
		return 90
	if string == "left":
		return -180
	if string == "right":
		return 0
