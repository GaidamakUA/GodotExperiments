extends Node
class_name Hp

signal died

export var hp := 10

func damage(damage: int) -> void:
	hp -= damage
	print(self, " hp left: ", hp)
	if hp == 0:
		emit_signal("died")