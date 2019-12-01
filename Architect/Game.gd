extends Node2D

var start_grid_position: Vector2 = Vector2()
var is_selecting := false

onready var selection_border:Control = $RectOutline
onready var tile_map: TileMap = $TileMap
onready var cell_size := tile_map.cell_size

func _ready():
	selection_border.rect_size = tile_map.cell_size

func _input(event):
	if event.is_action_released("left_click"):
		start_grid_position = Vector2()
		is_selecting = false
		return
	if event.is_action_pressed("left_click"):
		var drag_start_position = (event as InputEventMouse).global_position
		start_grid_position = tile_map.world_to_map(drag_start_position)
		is_selecting = true
	if is_selecting && event is InputEventMouseMotion:
		var end_grid_position := tile_map.world_to_map(event.global_position)
		
		var grid_size = end_grid_position - start_grid_position
		var fixed_grid_position = start_grid_position
		if grid_size.x < 0:
			grid_size.x = -grid_size.x
			fixed_grid_position.x -= grid_size.x
		if grid_size.y < 0:
			grid_size.y = -grid_size.y
			fixed_grid_position.y -= grid_size.y
		var start_position := tile_map.map_to_world(fixed_grid_position)
		var size = grid_size * cell_size
		
		selection_border.rect_global_position = start_position / 2
		selection_border.rect_size = size