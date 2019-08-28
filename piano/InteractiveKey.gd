extends Node2D

signal clicked
export (bool) var leftmost = false
export(AudioStream) var note_sound

func _ready():
	$PianoKey.leftmost = leftmost
	$AudioStreamPlayer2D.stream = note_sound

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action("ui_tap"):
		$PianoKey.pressed = event.pressed
		if event.pressed:
			emit_signal("clicked", self)
			$AudioStreamPlayer2D.play(0)
		print("tapped: ", event.pressed)