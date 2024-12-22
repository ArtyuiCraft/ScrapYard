extends CharacterBody2D

const SPEED = 300.0
var health = 10

func _ready():
	scale = Vector2(health/10,health/10)

func _physics_process(delta):
	pass

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
