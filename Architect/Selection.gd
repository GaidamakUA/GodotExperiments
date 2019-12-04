extends Node

class_name Selection

var first_grid_position := Vector2()
var rect := Rect2()
var is_selecting := false
var is_selected: bool setget ,_is_selected

func _is_selected() -> bool:
	return rect.get_area() > 0.1

func set_second_position(second_position: Vector2):
	var start_x = min(first_grid_position.x, second_position.x)
	var end_x = max(first_grid_position.x, second_position.x)
	var start_y = min(first_grid_position.y, second_position.y)
	var end_y = max(first_grid_position.y, second_position.y)
	rect.position = Vector2(start_x, start_y)
	rect.end = Vector2(end_x, end_y)
	print(rect)