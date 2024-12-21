extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var beltdirection
var onbelt
var directionx = 0.0
var directiony = 0.0
var item_collect = false

func _physics_process(delta):
	var areas = $"Pickup+Belt".get_overlapping_areas()
	for area in areas:
		if area.is_in_group("collector"):
			item_collect = true
	if !item_collect:
		for area in areas:
			if area.is_in_group("belt"):
				onbelt = true
				beltdirection = area.get_parent().tilerotation
			elif area.is_in_group("keepgoing"):
				if !onbelt:
					onbelt = true
					beltdirection = area.get_parent().tilerotation
				rotation_degrees = Utils.string_to_rotation(area.get_parent().tilerotation)
			else:
				onbelt = false
		if !$"Pickup+Belt".has_overlapping_areas():
			onbelt = false
	if onbelt and !item_collect:
		if beltdirection == "up":
			directiony = -0.5
			directionx = 0
		elif beltdirection == "down":
			directiony = 0.5
			directionx = 0
		elif beltdirection == "left":
			directionx = -0.5
			directiony = 0
		elif beltdirection == "right":
			directionx = 0.5
			directiony = 0
	else:
		directionx = 0
		directiony = 0
	item_collect = false

	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
