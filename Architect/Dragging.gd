extends Node

class_name Dragging

var is_dragging := false
var first_grid_position := Vector2()
var second_grid_position := Vector2()

func get_drag() -> Vector2:
	return second_grid_position - first_grid_position