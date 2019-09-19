extends KinematicBody2D

export var max_speed: int = 100
var speed := Vector2(max_speed, 0)

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		speed.x = max_speed
		move_and_collide(speed)
	if Input.is_action_pressed("ui_left"):
		speed.x = -max_speed
		move_and_collide(speed)