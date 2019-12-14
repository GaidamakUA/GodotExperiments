tool
extends ReferenceRect

export var draw_circles := true
export var draw_vectors := true
export var show_trace := true

var _circles := PoolVector2Array()
var _point_trace := PoolVector2Array()

func _draw():
	if _circles.size() == 0:
		return
	var position := rect_size / 2
	var max_radius := min(rect_size.x, rect_size.y) / 2
	var scale_radius := 0.0
	var last_point := Vector2()
	for circle in _circles:
		scale_radius += circle.length()
		last_point += circle
	var scale_factor := max_radius / scale_radius
	last_point = last_point * scale_factor + position
	_point_trace.insert(0, last_point)
	if _point_trace.size() > 100:
		_point_trace.resize(100)
	if show_trace:
		draw_multiline(_point_trace, Color.brown)
	for circle in _circles:
		if draw_circles:
			draw_circle_no_fill(position, circle.length() * scale_factor, Color.aqua)
		var small_position: Vector2 = circle * scale_factor
		var new_position := position + small_position
		if draw_vectors:
			draw_line(position, new_position, Color.wheat)
		position = new_position
		draw_circle(position, 3, Color.azure)

func draw_circle_no_fill(center, radius, color):
    var nb_points = 64
    var points_arc = PoolVector2Array()

    for i in range(nb_points + 1):
        var angle_point = deg2rad(360 + i * (360) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _on_CircleModel_circles_moved(circle: PoolVector2Array):
	_circles = circle
	update()