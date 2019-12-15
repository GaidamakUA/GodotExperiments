extends Node

signal circles_moved
signal term_added

func _ready():
	emit_signal("term_added", get_children())

func _process(delta):
	var fourier_terms := get_children()
	var circles := PoolVector2Array()
	for victim in fourier_terms:
		var fourier_term := victim as FourierTerm
		var angle_delta: float = fourier_term.frequency * PI * delta
		fourier_term.circle = fourier_term.circle.rotated(angle_delta)
		circles.append(fourier_term.circle)
	emit_signal("circles_moved", circles)

func reset():
	var fourier_terms := get_children()
	for victim in fourier_terms:
		var fourier_term := victim as FourierTerm
		fourier_term.reset()

func _on_AddButton_pressed():
	add_child(FourierTerm.new())
	reset()
	emit_signal("term_added", get_children())