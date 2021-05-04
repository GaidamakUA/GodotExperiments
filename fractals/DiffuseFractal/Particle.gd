extends KinematicBody2D

class_name Particle

signal settled

var speed: Vector2
export var _stopped := false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if speed && not _stopped:
		var parent := get_parent() as Control
		if position.x > parent.rect_size.x:
			position.x = parent.rect_size.x - 1
			speed.x = -speed.x
		if position.y > parent.rect_size.y:
			position.y = parent.rect_size.y - 1
			speed.y = -speed.y
		if position.x < 0:
			position.x = 1
			speed.x = -speed.x
		if position.y < 0:
			position.y = 1
			speed.y = -speed.y
		
		var collision := move_and_collide(speed)
		if collision:
			if collision.collider._stopped:
				_stopped = true
				emit_signal("settled")
			else:
				speed.x = -speed.x
				speed.y = -speed.y