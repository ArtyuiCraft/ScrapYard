@tool
extends Node2D

@export var item: PackedScene

@export_enum("up","down","left","right") var tilerotation: String = "right":
	set(newrotation):
		tilerotation = newrotation
		rotation_degrees = Utils.string_to_rotation(newrotation)

func _ready():
	var utils = preload("res://Globals/Utils.gd").new()
	GlobalTimer.connect("pulse",pulse)
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

func pulse():
	var new_scene = item.instantiate()
	add_child(new_scene)
	new_scene.position = $spawnpoint.position
	new_scene.reparent(get_parent())
