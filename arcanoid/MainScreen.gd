extends Node2D

func _on_Area2D_body_entered(body):
	print("You lost")
	get_parent().remove_child(body)
