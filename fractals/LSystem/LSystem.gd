extends Control

export(int, 20) var iterations := 8

func _ready():
	var axiom: String = $Axiom.axiom
	var plot: String = axiom
	for iteration in range(iterations):
		var new_plot: String
		for i in range(plot.length()):
			var char_unchanged = true
			for rule_item in $Rules.get_children():
				var rule := rule_item as Rule
				if rule.symbol == plot[i]:
					new_plot += rule.rule
					char_unchanged = false
			if char_unchanged:
				new_plot += plot[i]
		print(iteration, " ", new_plot)
		plot = new_plot
	print(String(plot))
	$Turtle.plot(String(plot))