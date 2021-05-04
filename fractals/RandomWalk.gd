extends Control

var points := PoolVector2Array()
var speed_vector = Vector2(0, 5)

func _ready():
	points.append(Vector2(rect_size.x / 2, rect_size.y / 2))

func _process(delta):
	var random_step = speed_vector.rotated(randf() * 2 * PI)
	var next_point = points[0] + random_step
	points.insert(0, next_point)
	print(points)
	update()

func _draw():
	if (points.size() > 1):
		draw_line(points[0], points[1], Color.azure)
#	draw_multiline(points, Color.azure)