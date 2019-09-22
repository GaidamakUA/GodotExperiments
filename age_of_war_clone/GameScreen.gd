extends Node2D

class_name GameScreen

signal game_ended

func _on_player1_lost():
	$GameEndedDialog.window_title = "Player 1 lost"
	$GameEndedDialog.show()
	emit_signal("game_ended")

func _on_player2_lost():
	$GameEndedDialog.window_title = "Player 2 lost"
	$GameEndedDialog.show()
	emit_signal("game_ended")

func add_spawn(spawn: OneByOneMob):
	add_child(spawn)
	self.connect("game_ended", spawn, "end_game")

func _on_GameEndedDialog_confirmed():
	get_tree().change_scene("res://MainMenu.tscn")
