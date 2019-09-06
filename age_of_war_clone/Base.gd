extends StaticBody2D

export(int, "P1", "P2") var player_number

const SpawnScene := preload("res://OneByOneMob.tscn")
class_name Base

signal player_lost

func _on_Hp_died() -> void:
	emit_signal("player_lost")

func _on_SpawnButton_pressed() -> void:
	if $SpawningArea.is_filled():
		return
	var instance := SpawnScene.instance()
	instance.player_number = player_number
	(get_parent() as Node2D).add_child(instance)
	instance.global_position = $SpawningPoint.global_position

func _on_Hp_hp_changed(hp: int):
	var scale: float = hp as float / $Hp.max_hp * 6
	print("scale: ", scale)
	$HpBar.scale = Vector2(scale, 1)