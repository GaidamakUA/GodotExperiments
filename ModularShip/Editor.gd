extends Node2D

class_name Editor

var flip_tile := false setget _on_flip_state_changed

onready var tile_map: TileMap = $TileMap
onready var tile_set: TileSet = tile_map.tile_set
onready var sprite: Sprite = $Sprite
var hull_tile = preload("res://tiles/hull_2x2/ship_hull_2x2_0.tres")

var map_position: Vector2
var tile_id := 0
var max_tile_id := 0
var brush_register := Dictionary()

func _ready():
	tile_set.create_tile(tile_id)
	tile_set.tile_set_texture(tile_id, hull_tile)
	sprite.texture = hull_tile

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var mouse_motion: InputEventMouseMotion = event
		var mouse_position = mouse_motion.position
		map_position = tile_map.world_to_map(mouse_position / scale)
		sprite.position = map_position * tile_map.cell_size
	if event.is_action_pressed("place_tile"):
		tile_map.set_cellv(map_position, tile_id, flip_tile)
	if event.is_action_pressed("delete_tile"):
		tile_map.set_cellv(map_position, TileMap.INVALID_CELL)

func set_brush(texture: AtlasTexture):
	if brush_register.has(texture):
		tile_id = brush_register.get(texture)
	else:
		max_tile_id += 1
		tile_set.create_tile(max_tile_id)
		tile_set.tile_set_texture(max_tile_id, texture)
		tile_id = max_tile_id
	sprite.texture = texture

func _on_flip_state_changed(value: bool):
	flip_tile = value
	sprite.flip_h = flip_tile
