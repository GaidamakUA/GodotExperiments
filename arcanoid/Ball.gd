extends KinematicBody2D

class_name Ball

export var max_velocity: int
var velocity: Vector2

func _physics_process(delta):
	var collision := move_and_collide(velocity)
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)

func launch():
	velocity = Vector2(max_velocity, 0)
	velocity = velocity.rotated(PI / 4)