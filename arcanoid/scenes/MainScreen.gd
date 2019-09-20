extends Node2D

func _on_Area2D_body_entered(body):
	get_parent().remove_child(body)
	get_tree().change_scene("res://scenes/MainMenu.tscn")
