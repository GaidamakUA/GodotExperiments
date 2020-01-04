extends Control

var _displacement := Vector2(0, 10)

func _draw():
	_draw_split_line(Vector2(10, 10), Vector2(rect_size.x - 10, 10), 8)

func _draw_split_line(start: Vector2, finish: Vector2, level: int):
	if level < 0:
		return
	var fixed_start := start + _displacement
	var fixed_finish := finish + _displacement
	draw_line(fixed_start, fixed_finish, Color.red)
		
	var vector := (fixed_finish - fixed_start) / 3
	vector = vector.snapped(Vector2(1, 1))
	_draw_split_line(fixed_start, fixed_start + vector, level - 1)
	_draw_split_line(fixed_finish - vector, fixed_finish, level - 1)