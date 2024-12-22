extends CharacterBody2D

const SPEED = 300.0
var health = 10
var damagedeal = 10

func _ready():
	scale = Vector2(health/10,health/10)

func _physics_process(delta):
	if $Area2D.has_overlapping_bodies():
		for i in $Area2D.get_overlapping_bodies():
			if i.get_parent().cantakedamage:
				i.get_parent().damage(damagedeal)

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
