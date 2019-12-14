extends Node

signal circles_moved
signal circle_added

func _process(delta):
	var fourier_terms := get_children()
	var circles := PoolVector2Array()
	for victim in fourier_terms:
		var fourier_term := victim as FourierTerm
		var angle_delta: float = fourier_term.frequency * PI * delta
		fourier_term.circle = fourier_term.circle.rotated(angle_delta)
		circles.append(fourier_term.circle)
	emit_signal("circles_moved", circles)