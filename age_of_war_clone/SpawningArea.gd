extends Area2D

var _bodies_count := 0

func _on_SpawningArea_body_entered(body):
	_bodies_count += 1

func _on_SpawningArea_body_exited(body):
	_bodies_count -= 1

func is_filled() -> bool :
	return _bodies_count > 0