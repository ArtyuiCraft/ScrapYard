extends CharacterBody2D

const SPEED = 100
var health = 10
var damagedeal = 10
var cantakedamage = true

@export var navigation: NavigationAgent2D

func _physics_process(_delta):
	var dir: Vector2 = global_position.direction_to(navigation.get_next_path_position() ).normalized()
	velocity = dir * SPEED
	move_and_slide()

func make_path():
	navigation.target_position = Utils.core

func _ready():
	scale = Vector2(health/10,health/10)
	GlobalTimer.connect("pulse",pulse)

func pulse():
	if $Area2D.has_overlapping_bodies():
		for i in $Area2D.get_overlapping_bodies():
			if i.get_parent() and i.get_parent().has_method("damage"):
				i.get_parent().damage(damagedeal)

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()

func _on_timer_timeout():
	make_path()
