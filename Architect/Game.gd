extends Node2D

onready var selection_border:Control = $RectOutline
onready var picture_layer: TileMap = $PictureLayer
onready var drag_layer: TileMap = $DragLayer
onready var selection: Selection = $Selection

var is_dragging := false
var drag_first_grid_position := Vector2()

func _ready():
	drag_layer.set_cell(0,0,0)

func _input(event):
	if event.is_action_released("left_click"):
		if is_dragging:
			is_dragging = false
		selection.is_selecting = false
		return
	if event.is_action_pressed("left_click"):
		if selection.is_selected:
			is_dragging = true
			drag_first_grid_position = to_grid(event.global_position)
		else:
			selection.is_selecting = true
			selection.first_grid_position = to_grid(event.global_position)
	if event is InputEventMouseMotion:
		if is_dragging:
			print("is_dragging")
			drag_layer.clear()
			var rect_size = selection.get_grid_size()
			var rect_start = selection.get_start_position()
			var drag_second_grid_position = to_grid(event.global_position)
			var drag_diff = drag_second_grid_position - drag_first_grid_position
			print("drad_diff", drag_diff)
			for x in range(0, rect_size.x):
				for y in range(0,rect_size.y):
					var vector := Vector2(x, y)
					var source:Vector2 = vector + rect_start
					var tile = picture_layer.get_cellv(source)
					print(source, ",tile=", tile)
					var dest:Vector2 = source + drag_diff
					print(dest)
					drag_layer.set_cellv(dest, tile)
		if selection.is_selecting:
			selection.second_grid_position = to_grid(event.global_position)
			selection_border.rect_global_position = from_grid(selection.get_start_position()) / 2
			selection_border.rect_size = from_grid(selection.get_grid_size())

func to_grid(world_position: Vector2) -> Vector2:
	return picture_layer.world_to_map(world_position)

func from_grid(grid_position: Vector2) -> Vector2:
	return picture_layer.map_to_world(grid_position)