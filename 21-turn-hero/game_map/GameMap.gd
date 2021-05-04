extends Node2D

class_name GameMap

func get_terrain_type(position: Vector2) -> int:
	var map_coords = $Terrain.world_to_map(position)
	var terrain_tile_id = $Terrain.get_cellv(map_coords)
	var terrain_name = $Terrain.tile_set.tile_get_name(terrain_tile_id)
	match terrain_name:
		"fort":
			return FORT
		"boss":
			return BOSS
		"hill":
			return ROCK_HILL
		"forest":
			return FOREST
		"grass":
			return PLAIN
		"desert":
			return DESERT
		"water":
			return WATER
	return -1

enum {FOREST, ROCK_HILL, PLAIN, DESERT, FORT, BOSS, WATER}
