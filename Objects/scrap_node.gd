@tool
extends Node2D

var rotations = ["up",'down','left','right']

# Called when the node enters the scene tree for the first time.
func _ready():
	$BlackBox.rotation_degrees = Utils.string_to_rotation(rotations.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
