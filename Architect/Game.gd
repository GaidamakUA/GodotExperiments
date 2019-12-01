extends Node2D

onready var selection_border:Control = $RectOutline
onready var tile_map: TileMap = $PictureLayer
onready var selection: Selection = $Selection

func _input(event):
	if event.is_action_released("left_click"):
		selection.is_selecting = false
		return
	if event.is_action_pressed("left_click"):
		selection.is_selecting = true
		selection.first_grid_position = to_grid(event.global_position)
	if selection.is_selecting && event is InputEventMouseMotion:
		selection.second_grid_position = to_grid(event.global_position)
		selection_border.rect_global_position = from_grid(selection.get_start_position()) / 2
		selection_border.rect_size = from_grid(selection.get_grid_size())

func to_grid(world_position: Vector2) -> Vector2:
	return tile_map.world_to_map(world_position)

func from_grid(grid_position: Vector2) -> Vector2:
	return tile_map.map_to_world(grid_position)