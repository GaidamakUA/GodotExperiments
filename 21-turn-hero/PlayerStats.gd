extends Node

var gold := 0

var base_damage = 1

var items := []

func get_damage() -> int:
	var damage = base_damage
	for item in items:
		damage += item.damage
	return damage
