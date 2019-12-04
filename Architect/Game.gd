extends Node2D

onready var selection_border:Control = $RectOutline
onready var picture_layer: TileMap = $PictureLayer
onready var drag_layer: TileMap = $DragLayer
onready var selection: Selection = $Selection
onready var dragging: Dragging = $Dragging

func _ready():
	drag_layer.set_cell(0,0,0)

func _input(event):
	if event.is_action_released("left_click"):
		if dragging.is_dragging:
			dragging.is_dragging = false
		selection.is_selecting = false
		return
	if event.is_action_pressed("left_click"):
		if selection.is_selected:
			dragging.is_dragging = true
			dragging.first_grid_position = to_grid(event.global_position)
		else:
			selection.is_selecting = true
			selection.first_grid_position = to_grid(event.global_position)
	if event is InputEventMouseMotion:
		if dragging.is_dragging:
			drag_layer.clear()
			var rect_size = selection.rect.size
			var rect_start = selection.rect.position
			dragging.second_grid_position = to_grid(event.global_position)
			for x in range(0, rect_size.x):
				for y in range(0,rect_size.y):
					var vector := Vector2(x, y)
					var source:Vector2 = vector + rect_start
					var tile = picture_layer.get_cellv(source)
					print(source, ",tile=", tile)
					var dest:Vector2 = source + dragging.get_drag()
					print(dest)
					drag_layer.set_cellv(dest, tile)
		if selection.is_selecting:
			selection.set_second_position(to_grid(event.global_position))
			selection_border.rect_global_position = from_grid(selection.rect.position) / 2
			selection_border.rect_size = from_grid(selection.rect.size)

func _copy_region(source: TileMap, source_rect: Rect2, dest: TileMap, dest_posisition:Vector2):
	for x in range(0, source_rect.size.x):
		for y in range(0, source_rect.size.y):
			var displacement := Vector2(x, y)
			var source_point := source_rect.position + displacement
			var tile := source.get_cellv(source_point)
			
			var dest_tile := dest_posisition + displacement
			dest.set_cellv(dest_tile, tile)

func to_grid(world_position: Vector2) -> Vector2:
	return picture_layer.world_to_map(world_position)

func from_grid(grid_position: Vector2) -> Vector2:
	return picture_layer.map_to_world(grid_position)