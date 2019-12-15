extends Node

class_name FourierTerm

export(int, 0, 3) var displacement := 0 setget new_displacement
export(float, 0, 50) var radius := 1.0 setget new_radius
export var frequency := 0

var circle: Vector2

func _ready():
	reset()

func reset():
	circle = Vector2(1, 0)
	circle.x = circle.x * radius
	circle = circle.rotated(displacement * PI / 2)

func new_displacement(value: int):
	if not get_parent():
		return
	displacement = value
	get_parent().reset()

func new_radius(value: float):
	if not get_parent():
		return
	radius = value
	if (circle.length() < 0.1):
		reset()
	else:
		circle = circle.normalized() * value