extends Node

func _on_loss():
	$AnimationPlayer.play("loss_animation")

func return_to_menu():
	get_tree().change_scene("res://scenes/MainMenu.tscn")