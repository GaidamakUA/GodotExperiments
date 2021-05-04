extends Control

var can_move = true
var Chisai = preload("res://enemies/Chisai.tres")
var Kobold = preload("res://enemies/Kobold.tres")
var CactusKing = preload("res://enemies/CactusKing.tres")
var Dragon = preload("res://enemies/Dragon.tres")
var TheSourcerer = preload("res://enemies/TheSourcerer.tres")

var turn_signs := PoolIntArray([
		Sign.NONE, Sign.A, Sign.A, Sign.B, Sign.A, Sign.B,
		Sign.C, Sign.A, Sign.B, Sign.A, Sign.A,
		Sign.C, Sign.C, Sign.A, Sign.B, Sign.C, Sign.A,
		Sign.B, Sign.A, Sign.A, Sign.B, Sign.C])

var turn := 0

func _ready():
	_on_turn_changed()
	_on_gold_changed()
	_on_damage_changed()

func _on_Hero_moved(new_position):
	turn += 1
	var enemy = _get_enemy()
	if enemy:
		can_move = false
		$EnemyUI.set_enemy(enemy)
	elif _get_terrain() == GameMap.FORT:
		$ShopUI.show_shop()
	_on_turn_changed()

func _on_Enemy_dead(gold_drop, monster_name):
	if monster_name == "The Sourcerer":
		$VictoryDialog.show()
	else:
		PlayerStats.gold += gold_drop
		_on_gold_changed()
		can_move = true

func _on_end_game_confirmed():
	get_tree().reload_current_scene()

func _on_turn_changed():
	if turn > 21:
		$EnemyUI.hide()
		$LossDialog.show()
		return
	$VBoxContainer/Turns.text = str("Turns: ", 21 - turn, "/21")
	$VBoxContainer/TurnSign.text = str("Turn sign: ", _get_sign_text())

func _on_gold_changed():
	$VBoxContainer/Gold.text = str("Gold: ", PlayerStats.gold, "G")

func _on_damage_changed():
	$VBoxContainer/Damage.text = str("Battle Power: ", PlayerStats.get_damage())

func _get_sign() -> int:
	return turn_signs[turn]

func _get_sign_text() -> String:
	match(_get_sign()):
		Sign.NONE: return "-"
		Sign.A: return "A"
		Sign.B: return "B"
		Sign.C: return "C"
	return "Shouldn't happen"

func _get_enemy():
	match [_get_sign(), _get_terrain()]:
		[Sign.A, GameMap.DESERT]: return Kobold
		[Sign.A, GameMap.FOREST]: return Chisai
		[Sign.A, GameMap.PLAIN]: return Chisai
		[Sign.A, GameMap.ROCK_HILL]: return CactusKing
		[Sign.B, GameMap.DESERT]: return CactusKing
		[Sign.B, GameMap.FOREST]: return Kobold
		[Sign.B, GameMap.PLAIN]: return Kobold
		[Sign.B, GameMap.ROCK_HILL]: return Dragon
		[Sign.C, GameMap.DESERT]: return Dragon
		[Sign.C, GameMap.FOREST]: return CactusKing
		[Sign.C, GameMap.PLAIN]: return CactusKing
		[_, GameMap.BOSS]: return TheSourcerer
	return null

func _on_enemy_hit():
	turn += 1
	_on_turn_changed()

func _get_terrain() -> int:
	return $Map.get_terrain_type($Hero.global_position)

enum Sign {NONE, A, B, C}


func _on_ShopUI_interaction_finished():
	_on_damage_changed()
	_on_gold_changed()
	can_move = true


func _on_ShopUI_potion_used():
	turn -= 5
	if turn < 0:
		turn = 0
	_on_turn_changed()
