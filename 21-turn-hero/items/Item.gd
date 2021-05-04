extends Resource

class_name Item

export(String) var name: String
export(String) var description: String
export(int, 1, 20) var price: int

func is_available(gold: int) -> bool:
	return gold >= price
