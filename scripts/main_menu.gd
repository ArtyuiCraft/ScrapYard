extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/World.tscn")
	#queue_free()


func _on_tutorial_pressed():
	$Window.visible = true

func _on_window_close_requested():
	$Window.visible = false
