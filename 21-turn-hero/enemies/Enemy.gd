extends Resource

class_name Enemy

export(Texture) var enemy_image: Texture
export(String) var monster_name: String
export(int, 1, 10) var monster_rating: int
export(int, 0, 10) var gold_drop: int
