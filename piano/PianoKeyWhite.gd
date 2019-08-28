extends Node2D

var pressed := false setget set_pressed
var leftmost := false

func _ready():
	$piano_white_key_normal.show()
	$piano_white_key_pressed.hide()
	$piano_white_key_leftmost_pressed.hide()

func set_pressed(new_pressed: bool):
	pressed = new_pressed
	$piano_white_key_normal.hide()
	$piano_white_key_pressed.hide()
	$piano_white_key_leftmost_pressed.hide()
	if pressed && leftmost:
		$piano_white_key_leftmost_pressed.show()
	elif pressed && not leftmost:
		$piano_white_key_pressed.show()
	else:
		$piano_white_key_normal.show()