extends Node2D

@export_enum("up","down","left","right") var tilerotation: String = "right":
	set(newrotation):
		tilerotation = newrotation
		rotation_degrees = Utils.string_to_rotation(newrotation)

func _ready():
	var utils = preload("res://Globals/Utils.gd").new()
	var mouserotation = get_parent().get_parent().mouserotation
	if mouserotation == 0:
		tilerotation = "right"
	if mouserotation == 1:
		tilerotation = "down"
	if mouserotation == 2:
		tilerotation = "left"
	if mouserotation == 3:
		tilerotation = "up"
	rotation_degrees = Utils.string_to_rotation(tilerotation)

func _process(delta):
	var mouserotation = get_parent().get_parent().mouserotation
	if mouserotation == 1:
		tilerotation = "right"
	if mouserotation == 2:
		tilerotation = "down"
	if mouserotation == 3:
		tilerotation = "left"
	if mouserotation == 4:
		tilerotation = "up"
	rotation_degrees = Utils.string_to_rotation(tilerotation)
