extends Control

func _draw():
#	draw_line(Vector2(10, 10), Vector2(rect_size.x - 10, 10), Color.red)
	_draw_koch(Vector2(10, 10), Vector2(rect_size.x - 10, 10), 6)

func _draw_koch(start: Vector2, finish: Vector2, level: int):
	if level == 0:
		draw_line(start, finish, Color.red)
		return
		
	var vector := (finish - start) / 3
	vector = vector.snapped(Vector2(1, 1))
	if vector.length_squared() < 1:
		print(level)
	var middle_point = vector + vector.rotated(PI / 3)
	middle_point = middle_point.snapped(Vector2(1, 1))
	_draw_koch(start, start + vector, level - 1)
	_draw_koch(start + vector, start + middle_point, level - 1)
	_draw_koch(start + middle_point, finish - vector, level - 1)
	_draw_koch(finish - vector, finish, level - 1)