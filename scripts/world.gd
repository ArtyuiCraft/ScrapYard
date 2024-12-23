extends Node2D

@onready var mouse_pos = $Ghosts.local_to_map(get_global_mouse_position())
@onready var player = $Player
@export var red_ghost: Color
@export var ghost: Color
var mouserotation = 0
@export var scene: PackedScene
@export var colorred: Color
@export var colorwhite: Color
var break_mouse_pos
var inbreak = true
var waveongoing = false
var wavetimergoing = false
var wave = 0
const notile = Vector2i(-1,-1)
var wavestart = false
var enemies = 0
var cantakedamage = false

func _ready():
	GlobalTimer.connect("pulse",pulse)

func _process(delta):
	$spawnshape.position.x = 2000
	$spawnshape.position.y = 2000
	if !$WaveTimer.is_stopped():
		$GuiLayer/gui/wavetimer.text = "Next wave in: " + str(int(ceil($WaveTimer.time_left))) + " sec"
		$GuiLayer/gui/wavetimer.modulate = colorwhite
	else:
		$GuiLayer/gui/wavetimer.text = "WAVE STARTED"
		$GuiLayer/gui/wavetimer.modulate = colorred
	if $WaveTimer.is_stopped() and wavetimergoing and !wavestart:
		wavestart = true
		wavetimergoing = false
		enemies = (wave + 1) * 5
	if !wavestart and $WaveTimer.is_stopped():
		wavetimergoing = true
		$WaveTimer.start()
	$GuiLayer/gui/wavescore.text = "Wave: " + str(wave)
	if Input.is_action_just_pressed("rotate+"):
		mouserotation = wrap(mouserotation + 1,0,4)
	if Input.is_action_just_pressed("rotate-"):
		mouserotation = wrap(mouserotation - 1,0,4)
	$Ghosts.erase_cell(mouse_pos)
	mouse_pos = $Ghosts.local_to_map(get_global_mouse_position())
	$Ghosts.set_cell(mouse_pos, 1,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
	if player.hotbar[player.selected_item % len(player.hotbar)] == 3:
			if $World.get_cell_atlas_coords(mouse_pos) == Vector2i(0,0) and !($World.local_to_map(player.position) == mouse_pos):
				$Ghosts.modulate = ghost
				$Ghosts.self_modulate = ghost
			else:
				$Ghosts.modulate = red_ghost
				$Ghosts.self_modulate = red_ghost
	else:
		if $World.get_cell_atlas_coords(mouse_pos) != notile or ($World.local_to_map(player.position) == mouse_pos):
			$Ghosts.modulate = red_ghost
			$Ghosts.self_modulate = red_ghost
		else:
			$Ghosts.modulate = ghost
			$Ghosts.self_modulate = ghost
	if Input.is_action_pressed("place"):
		if player.scrap >= player.selected_cost and ($Objects.get_cell_atlas_coords(mouse_pos) == notile):
			if player.hotbar[player.selected_item % len(player.hotbar)] == 3:
				if $World.get_cell_atlas_coords(mouse_pos) == Vector2i(0,0):
					$Objects.set_cell(mouse_pos, 0,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
					player.scrap -= player.selected_cost
			else:
				if $World.get_cell_atlas_coords(mouse_pos) == notile and !($World.local_to_map(player.position) == mouse_pos):
					$Objects.set_cell(mouse_pos, 0,Vector2i(0,0),player.hotbar[player.selected_item % len(player.hotbar)])
					player.scrap -= player.selected_cost
	if !$BreakTimer.is_stopped():
		$GuiLayer/gui/ProgressBar.value = ($BreakTimer.wait_time - $BreakTimer.time_left) * 1000
	else:
		$GuiLayer/gui/ProgressBar.value = 0
	if Input.is_action_pressed("break") and !inbreak and !$Objects.get_cell_atlas_coords(mouse_pos) == notile:
		$BreakTimer.start()
		break_mouse_pos = mouse_pos
		inbreak = true
	if Input.is_action_just_released("break"):
		$BreakTimer.stop()
		inbreak = false
	if mouse_pos != break_mouse_pos and !$BreakTimer.is_stopped():
		$BreakTimer.stop()
		inbreak = false
	if $BreakTimer.is_stopped() and inbreak:
		player.scrap += player.cost[$Objects.get_cell_atlas_coords(mouse_pos).x]
		$Objects.erase_cell(mouse_pos)
		inbreak = false
	#if Input.is_action_just_pressed("spawn"):
	#	var new_scene = scene.instantiate()
	#	add_child(new_scene)
	#	new_scene.position = get_global_mouse_position()

func pulse():
	var rect : Rect2 = $spawnshape.shape.get_rect()
	var x = randi_range($spawnshape.position.x, rect.position.x+rect.size.x)
	var y = randi_range($spawnshape.position.y, rect.position.y+rect.size.y)
	var rand_point = Vector2(x,y)
	if enemies > 0:
		var new_scene = scene.instantiate()
		add_child(new_scene)
		new_scene.position = rand_point
		enemies -= 1
