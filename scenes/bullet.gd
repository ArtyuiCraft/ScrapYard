extends StaticBody2D

var cantakedamage = false
var speed: float = 100
var damage = 10

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_collison_body_entered(body):
	body.damage()
	queue_free()
