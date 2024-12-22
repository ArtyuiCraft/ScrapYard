extends Node2D

var hp = 500
var cantakedamage = true

func _ready():
	pass

func _process(delta):
	pass

func damage(amount):
	hp -= amount
	if hp <= 0:
		print("game over")
