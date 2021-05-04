tool
extends Item

class_name Wearable

export(int, 1, 3) var damage: int setget _set_damage

func _set_damage(value: int):
	damage = value
	description = str("+", damage, " BP")
