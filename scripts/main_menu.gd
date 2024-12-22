extends Control



func _ready():
	DiscordRPC.app_id = 1320371630761050122
	DiscordRPC.details = "A game made for minijam 174"
	DiscordRPC.state = "Scrap: 0 Core hp: 100"
	DiscordRPC.large_image = "turret"
	DiscordRPC.large_image_text = "Play it at:"
	DiscordRPC.small_image = "rock"
	DiscordRPC.small_image_text = "Made by Artyui and Spindlebink"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()

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
