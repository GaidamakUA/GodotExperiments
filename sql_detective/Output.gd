extends RichTextLabel

func set_result(rows: Array) -> void:
	clear()
	if not rows || rows.size() == 0:
		return
	var result = String()
	result += "[code]"
	for key in rows[0].keys():
		result += key
		result += "\t"
	result += "\n"
	
	for row in rows:
		for key in rows[0].keys():
			result += row[key]
			result += "\t"
		result += "\n"
	result += "[/code]"
	set_bbcode(result)