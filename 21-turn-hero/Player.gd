extends Sprite

signal moved(new_position)

func _unhandled_input(event):
	if not get_parent().can_move:
		return
	var change = Vector2.ZERO
	if event.is_action_pressed("ui_down") && can_move($Down):
		change += Vector2.DOWN * 128
	if event.is_action_pressed("ui_up") && can_move($Up):
		change += Vector2.UP * 128
	if event.is_action_pressed("ui_left") && can_move($Left):
		change += Vector2.LEFT * 128
	if event.is_action_pressed("ui_right") && can_move($Right):
		change += Vector2.RIGHT * 128
	if (change != Vector2.ZERO):
		position += change
		emit_signal("moved", position)

func can_move(raycast: RayCast2D) -> bool:
	return not raycast.is_colliding()
