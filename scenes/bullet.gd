extends StaticBody2D

var speed: float = 100

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
