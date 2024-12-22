extends Node2D

@export_enum("up","down","left","right") var tilerotation: String = "right":
	set(newrotation):
		tilerotation = newrotation
		rotation_degrees = Utils.string_to_rotation(newrotation)
@export var bullet: PackedScene

var bullets = 0
var better_bullets = 0
var lookback = false
var target_angle = 0

func _ready():
	var utils = preload("res://Globals/Utils.gd").new()
	var mouserotation = get_parent().get_parent().mouserotation
	if mouserotation == 0:
		tilerotation = "right"
	if mouserotation == 1:
		tilerotation = "down"
	if mouserotation == 2:
		tilerotation = "left"
	if mouserotation == 3:
		tilerotation = "up"
	rotation_degrees = Utils.string_to_rotation(tilerotation)

func _process(delta):
	if $range.has_overlapping_bodies():
		$lookback.stop()
		lookback = false
		var target_body = $range.get_overlapping_bodies()[0]
		target_angle = $pivot.global_position.angle_to_point(target_body.global_position) - rotation
		$pivot.rotation = lerp_angle($pivot.rotation, target_angle, 5 * delta)
		if $pivot/FiringRange.has_overlapping_bodies() and $shootdelay.is_stopped() and bullets > 0:
			var new_scene = bullet.instantiate()
			add_child(new_scene)
			new_scene.rotation = $pivot.rotation
			if better_bullets > 0:
				new_scene.damage = 50
				better_bullets -= 1
			else:
				new_scene.damage = 10
				bullets -= 1
			new_scene.reparent(get_parent())
			$shootdelay.start()
	else:
		if !lookback and $lookback.is_stopped():
			$lookback.start()
			lookback = true
		if !$lookback.is_stopped():
			$pivot.rotation = lerp_angle($pivot.rotation, target_angle, 5 * delta)
		else:
			$pivot.rotation = lerp_angle($pivot.rotation, 0, 5 * delta)
	if $bulletacceptor.has_overlapping_areas():
		for area in $bulletacceptor.get_overlapping_areas():
			if area.get_parent().get_parent().name == "BulletItem":
				bullets += 1
				area.get_parent().get_parent().queue_free()
			if area.get_parent().get_parent().name == "BetterBulletItem":
				better_bullets += 1
				area.get_parent().get_parent().queue_free()
