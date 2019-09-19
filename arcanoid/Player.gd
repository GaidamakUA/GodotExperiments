extends KinematicBody2D

export var max_speed: int
var speed := Vector2(max_speed, 0)

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		speed.x = max_speed
		move_and_collide(speed)
	if Input.is_action_pressed("ui_left"):
		speed.x = -max_speed
		move_and_collide(speed)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		var ball := $Ball as Ball
		var ball_position = ball.global_position
		remove_child(ball)
		get_parent().add_child(ball)
		ball.global_position = ball_position
		ball.launch()