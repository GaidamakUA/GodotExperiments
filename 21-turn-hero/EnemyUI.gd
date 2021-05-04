extends Panel

signal dead(gold_drop, monster_name)
signal enemy_hit()

var hp: int
var gold_drop: int
var monster_name: String

func set_enemy(enemy: Enemy):
	hp = enemy.monster_rating
	gold_drop = enemy.gold_drop
	monster_name = enemy.monster_name
	
	$HBoxContainer/TextureRect.texture = enemy.enemy_image
	$HBoxContainer/Name.text = str("Name: ", enemy.monster_name)
	$HBoxContainer/Rating.text = str("Rating: ", enemy.monster_rating)
	$HBoxContainer/Drop.text = str("Gold Drop: ", enemy.gold_drop, "G")
	$HBoxContainer/HP.text = str("HP:", hp)
	
	show()

func _on_HitButton_pressed():
	if $AnimationPlayer.is_playing():
		return
	hp -= PlayerStats.get_damage()
	$HBoxContainer/HP.text = str("HP:", hp)
	if (hp <= 0):
		hide()
		emit_signal("dead", gold_drop, monster_name)
	else:
		$AnimationPlayer.play("hit")
		emit_signal("enemy_hit")
