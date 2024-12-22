extends Node2D

@export var node: Node2D
var ZoomSpeed = Vector2(0.1,0.1)
var MinZoom   = Vector2(0.4,0.4)
var MaxZoom   = Vector2(1.5,1.5)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = node.position
	if Input.is_action_just_released("Scroll_up"):
		$Camera2D.zoom = clamp($Camera2D.zoom + ZoomSpeed, MinZoom, MaxZoom)
	if Input.is_action_just_released("Scroll_down"):
		$Camera2D.zoom = clamp($Camera2D.zoom - ZoomSpeed, MinZoom, MaxZoom)
