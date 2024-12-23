extends Node2D

@export_enum("up","down","left","right") var tilerotation: String = "right":
	set(newrotation):
		tilerotation = newrotation
		rotation_degrees = Utils.string_to_rotation(newrotation)
@export_enum("bullets","betterbullets") var recipe: int

var hp = 40
var cantakedamage = true
var has_recipe = false
var busy = false
var items = {"Scrap": 0, "BulletItem": 0}

func _ready():
	var utils = preload("res://Globals/Utils.gd").new()
	GlobalTimer.connect("pulse",pulse)
	var mouserotation = get_parent().get_parent().mouserotation
	$"../../GuiLayer/gui/recipes".visible = true
	$"../../GuiLayer/gui/recipes".connect("item_selected",set_recipe)
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
	var to_remove = []
	for i in $in.get_overlapping_areas():
		if i.is_in_group("item"):
			var item_name = i.get_parent().itemname
			if items.has(item_name):
				items[item_name] += 1
				to_remove.append(i.get_parent().get_parent())
	for item in to_remove:
		item.queue_free()

func pulse():
	if busy:
		$">P>".text = " P>"
		busy = false
		if recipe == 0:
			var new_scene = preload("res://Items/BulletItem.tscn").instantiate()
			add_child(new_scene)
			new_scene.position = $out.position
		if recipe == 1:
			var new_scene = preload("res://Items/BetterBulletItem.tscn").instantiate()
			add_child(new_scene)
			new_scene.position = $out.position
	if !busy:
		$">P>".text = ">P>"
		if recipe == 0:
			if items["Scrap"] >= 1:
				items["Scrap"] -= 1
				busy = true
		if recipe == 1:
			if items["Scrap"] >= 1 and items["BulletItem"] >= 1:
				items["Scrap"] -= 1
				busy = true
func set_recipe(idx):
	if has_recipe:
		return
	recipe = idx
	$"../../GuiLayer/gui/recipes".visible = false
	has_recipe = true
	$"../../GuiLayer/gui/recipes".selected = -1

func damage(amount):
	hp -= amount
	if hp <= 0:
		queue_free()
