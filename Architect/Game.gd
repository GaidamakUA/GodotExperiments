extends Node2D

onready var selection_border:Control = $RectOutline
onready var picture_layer: TileMap = $PictureLayer
onready var drag_layer: TileMap = $DragLayer
onready var selection: Selection = $Selection
onready var dragging: Dragging = $Dragging

func _input(event):
	if event.is_action_released("left_click"):
		if dragging.is_dragging:
			selection.rect = Rect2()
			dragging.is_dragging = false
			var used_cells = drag_layer.get_used_cells()
			for cellv in used_cells:
				var tile = drag_layer.get_cellv(cellv)
				picture_layer.set_cellv(cellv, tile)
			drag_layer.clear()
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
			dragging.second_grid_position = to_grid(event.global_position)
			var dest_position = selection.rect.position + dragging.get_drag()
			_copy_region(picture_layer, selection.rect, drag_layer, dest_position)
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