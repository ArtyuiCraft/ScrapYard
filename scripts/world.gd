extends Node2D

@onready var mouse_pos = $Ghosts.local_to_map(get_global_mouse_position())
@onready var player = $Player
@export var red_ghost: Color
@export var ghost: Color
var mouserotation = 0
@export var scene: PackedScene

func _process(delta):
	if Input.is_action_just_pressed("rotate+"):
		mouserotation = wrap(mouserotation + 1,0,4)
	if Input.is_action_just_pressed("rotate-"):
		mouserotation = wrap(mouserotation - 1,0,4)
	$Ghosts.erase_cell(mouse_pos)
	mouse_pos = $Ghosts.local_to_map(get_global_mouse_position())
	$Ghosts.set_cell(mouse_pos, 1,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
	if player.hotbar[player.selected_item % len(player.hotbar)] == 3:
			if $World.get_cell_atlas_coords(mouse_pos) == Vector2i(0,0):
				$Ghosts.modulate = ghost
				$Ghosts.self_modulate = ghost
			else:
				$Ghosts.modulate = red_ghost
				$Ghosts.self_modulate = red_ghost
	else:
		if $World.get_cell_atlas_coords(mouse_pos) != Vector2i(-1,-1):
			$Ghosts.modulate = red_ghost
			$Ghosts.self_modulate = red_ghost
		else:
			$Ghosts.modulate = ghost
			$Ghosts.self_modulate = ghost
	if Input.is_action_pressed("place"):
		if player.hotbar[player.selected_item % len(player.hotbar)] == 3:
			if $World.get_cell_atlas_coords(mouse_pos) == Vector2i(0,0):
				$Objects.set_cell(mouse_pos, 0,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
		else:
			if $World.get_cell_atlas_coords(mouse_pos) == Vector2i(-1,-1):
				$Objects.set_cell(mouse_pos, 0,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
	if Input.is_action_pressed("break"):
		$Objects.erase_cell(mouse_pos)
	#if Input.is_action_just_pressed("spawn"):
	#	var new_scene = scene.instantiate()
	#	add_child(new_scene)
	#	new_scene.position = get_global_mouse_position()
