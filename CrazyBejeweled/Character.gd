extends KinematicBody2D

export var max_speed: int = 10

func _physics_process(delta):
	var speed = Vector2(0, 0)
	if Input.is_action_pressed("ui_down"):
		speed.y += max_speed 
	if Input.is_action_pressed("ui_up"):
		speed.y -= max_speed
	if Input.is_action_pressed("ui_left"):
		speed.x -= max_speed
	if Input.is_action_pressed("ui_right"):
		speed.x += max_speed
	move_and_collide(speed)