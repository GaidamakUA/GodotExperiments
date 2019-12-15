extends ReferenceRect

export var plot_y := true
export var plot_x := true

var _points := PoolVector2Array()

func _draw():
	var amplitude = rect_size.y / 2
	var y_points := PoolRealArray()
	var x_points := PoolRealArray()
	for point in _points:
		y_points.append(point.y)
		x_points.append(point.x)
	if plot_y:
		_plot_line_data(y_points, Color.bisque)
	if plot_x:
		_plot_line_data(x_points, Color.cadetblue)

# Data points shoud be under 1
func _plot_line_data(data: PoolRealArray, color: Color):
	var amplitude: float = rect_size.y / 2
	var plot_points := PoolVector2Array()
	for i in range(data.size()):
		var value: float = data[i] * amplitude + amplitude
		var point = Vector2(i, value)
		plot_points.append(point)
	draw_polyline(plot_points, color, 1, true)

func _on_CircleModel_circles_moved(circles: PoolVector2Array):
	var sum_point := Vector2(0, 0)
	var max_value := 0.0
	for circle in circles:
		sum_point += circle
		max_value += circle.length()
	sum_point = sum_point / max_value
	_points.insert(0, sum_point)
	if (_points.size() > rect_size.x):
		_points.resize(rect_size.x)
	update()