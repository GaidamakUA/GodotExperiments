extends Node

signal circles_moved

var _angle_speed_0 := PI
var _angle_speed_1 := -2 * PI
var _circle_0 := Vector2(1, 0)
var _circle_1 := Vector2(1, 0)

func _process(delta):
	_circle_0 = _circle_0.rotated(_angle_speed_0 * delta)
	_circle_1 = _circle_1.rotated(_angle_speed_1 * delta)
	var circles = PoolVector2Array()
	circles.append(_circle_0)
	circles.append(_circle_1)
	emit_signal("circles_moved", circles)