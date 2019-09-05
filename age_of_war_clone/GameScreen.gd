extends Node2D

func _on_player2_lost():
	$AcceptDialog.window_title = "Player 2 lost"
	$AcceptDialog.show()