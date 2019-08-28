extends Sprite

onready var tween := $Tween as Tween
var _current_path: PoolVector2Array = PoolVector2Array()

func move_along_the_path(var path: PoolVector2Array):
	if tween.is_active:
		return
	
	_current_path = path
	_next_step()

func _next_step():
	if _current_path.size() == 0:
		return
	tween.interpolate_property(self, "position", 
			position, _current_path[0], 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	_current_path.remove(0)

func _on_Tween_tween_all_completed():
	_next_step()
