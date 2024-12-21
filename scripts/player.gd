extends CharacterBody2D

const SPEED = 300.0
var hotbar = [1,2,3,4]
var selected_item = 0
var onbelt = false
var beltdirection

func _physics_process(delta):
	var directionx = Input.get_axis("left", "right")
	var directiony = Input.get_axis("up", "down")
	
	if Input.is_action_just_pressed("hotbar slot 1"):
		selected_item = 0
	if Input.is_action_just_pressed("hotbar slot 2"):
		selected_item = 1
	if Input.is_action_just_pressed("hotbar slot 3"):
		selected_item = 2
	if Input.is_action_just_pressed("hotbar slot 4"):
		selected_item = 3
	if Input.is_action_just_pressed("hotbar slot 5"):
		selected_item = 4
	if Input.is_action_just_pressed("hotbar slot 6"):
		selected_item = 5
	if Input.is_action_just_pressed("hotbar slot 7"):
		selected_item = 6
	if Input.is_action_just_pressed("hotbar slot 8"):
		selected_item = 7
	if Input.is_action_just_pressed("hotbar slot 9"):
		selected_item = 8
	if Input.is_action_just_pressed("hotbar slot 10"):
		selected_item = 9
	
	var areas = $Area2D.get_overlapping_areas()
	for area in areas:
		if area.is_in_group("belt"):
			print("as")
			onbelt = true
			beltdirection = area.get_parent().tilerotation
		elif area.is_in_group("keepgoing"):
			if !onbelt:
				onbelt = true
				beltdirection = area.get_parent().tilerotation
		else:
			onbelt = false
	if !$Area2D.has_overlapping_areas():
		onbelt = false

	if onbelt:
		if beltdirection == "up":
			directiony -= 0.5
		if beltdirection == "down":
			directiony += 0.5
		if beltdirection == "left":
			directionx -= 0.5
		if beltdirection == "right":
			directionx += 0.5

	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()