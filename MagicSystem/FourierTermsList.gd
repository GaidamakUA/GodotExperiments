extends VBoxContainer

signal term_selected

var _text_format := "{a} * cos({w} * PI * theta) + {d} * PI"

func _on_CircleModel_term_added(terms_list: Array):
	for i in range(1, get_child_count()):
		print(i)
		var child = get_child(i)
		child.queue_free()
	for victim in terms_list:
		var term: FourierTerm = victim as FourierTerm
		var coefficient = term.circle.length()
		var displacement = term.circle.angle() / PI
		var frequency = term.frequency
		var child = Button.new()
		child.text = _text_format.format({"a": coefficient, "w": frequency, "d": displacement})
		child.connect("button_down", self, "_on_item_click", [term])
		add_child(child)

func _on_item_click(term: FourierTerm):
	emit_signal("term_selected", term)