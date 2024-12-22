extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tutorial"):
		if $Window.visible:
			$Window.visible = false
		else:
			$Window.visible = true

func _on_window_close_requested():
	$Window.visible = false
