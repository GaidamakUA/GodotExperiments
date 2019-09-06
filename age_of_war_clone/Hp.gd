extends Node
class_name Hp

signal died
signal hp_changed

export var max_hp := 10
var hp := max_hp

func damage(damage: int) -> void:
	hp -= damage
	print(self, " hp left: ", hp)
	emit_signal("hp_changed", hp)
	if hp == 0:
		emit_signal("died")