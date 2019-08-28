extends Node2D

var pressed := false setget set_pressed
var leftmost := false

func _ready():
	$black_key_normal.show()
	$black_key_pressed.hide()

func set_pressed(new_pressed: bool):
	pressed = new_pressed
	$black_key_normal.hide()
	$black_key_pressed.hide()
	if pressed:
		$black_key_pressed.show()
	else:
		$black_key_normal.show()