extends Node

class_name Selection

var first_grid_position := Vector2()
var second_grid_position := Vector2()
var is_selecting := false

func get_grid_size() -> Vector2:
	var fixed_grid_size := _get_size()
	if fixed_grid_size.x < 0:
		fixed_grid_size.x = -fixed_grid_size.x
	else:
		fixed_grid_size.x += 1
	if fixed_grid_size.y < 0:
		fixed_grid_size.y = -fixed_grid_size.y
	else:
		fixed_grid_size.y += 1
	return fixed_grid_size

func get_start_position() -> Vector2:
	var grid_size := _get_size()
	var fixed_start_position = Vector2(first_grid_position.x, first_grid_position.y)
	if grid_size.x < 0:
		fixed_start_position.x += grid_size.x
	if grid_size.y < 0:
		fixed_start_position.y += grid_size.y
	return fixed_start_position

func _get_size() -> Vector2:
	return second_grid_position - first_grid_position