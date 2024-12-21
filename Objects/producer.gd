@tool
extends Node2D

@export_enum("up","down","left","right") var tilerotation: String = "right":
	set(newrotation):
		tilerotation = newrotation
		rotation_degrees = Utils.string_to_rotation(newrotation)
@export_enum("bullets") var recipe: int

var busy = false
var items = {"Scrap": 0}

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
	if $in.has_overlapping_areas() and !busy:
		for i in $in.get_overlapping_areas():
			if i.get_parent().get_parent().name in ("Scrap"):
				items[i.get_parent().get_parent().name] += 1
				i.get_parent().get_parent().queue_free()
	if busy:
		busy = false
		if recipe == 0:
			var new_scene = preload("res://Items/BulletItem.tscn").instantiate()
			add_child(new_scene)
			new_scene.position = $out.position
	if !busy:
		if recipe == 0:
			if items["Scrap"] >= 2:
				items["Scrap"] -= 2
				busy = true
