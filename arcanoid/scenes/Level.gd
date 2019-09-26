extends Node2D

signal loss

func _on_Area2D_body_entered(body):
	get_parent().remove_child(body)
	emit_signal("loss")