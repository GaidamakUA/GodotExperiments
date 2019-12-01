extends Control

func _draw():
	draw_rect(Rect2(rect_global_position, rect_size), Color.red, false)