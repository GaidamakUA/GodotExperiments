extends Node2D

const SCREEN_WIDTH = 19

onready var astar = AStar.new()
onready var used_cells:Array = $TileMap.get_used_cells()
onready var castles:Array = $TileMap.get_used_cells_by_id(5)

func _ready():
	for cell in used_cells:
		var cell_id := get_cell_id(cell)
		astar.add_point(cell_id, Vector3(cell.x, cell.y, 0))
	for cell in used_cells:
		var cell_id := get_cell_id(cell)
		var neighbour_ids := get_neighbour_ids(cell)
		for neighbour_id in neighbour_ids:
			if not astar.has_point(neighbour_id):
				continue
			astar.connect_points(cell_id, neighbour_id)
	var firstCell: Vector2 = used_cells[0]
	var firstCellCoordinates = $TileMap.map_to_world(firstCell)
	$MainCharacter.position = firstCellCoordinates
	$RandomWalker.position = firstCellCoordinates

func _unhandled_input(event):
	if event is InputEventMouseButton \
			&& event.button_index == BUTTON_LEFT \
			&& event.is_pressed():
		var position: Vector2 = event.global_position / 2
		var tile_index: Vector2 = $TileMap.world_to_map(position)
		var tile_type: int = $TileMap.get_cellv(tile_index)
		if tile_type == 5:
			var character_index = $TileMap.world_to_map($MainCharacter.position)
			var path = _get_path(character_index, tile_index)
			$MainCharacter.move_along_the_path(path)

func _get_path(from: Vector2, to: Vector2) -> PoolVector2Array:
	var from_id: int = get_cell_id(from)
	var to_id: int = get_cell_id(to)
	var array_3d = astar.get_point_path(from_id, to_id)
	var to_return = PoolVector2Array()
	for coordinate in array_3d:
		var cell_index = Vector2(coordinate.x, coordinate.y)
		var cell_position = $TileMap.map_to_world(cell_index)
		to_return.append(cell_position)
	return to_return

func get_cell_id(cell: Vector2) -> int:
	return int(cell.x) + int(cell.y) * SCREEN_WIDTH

func get_neighbour_ids(cell: Vector2) -> PoolIntArray:
	return PoolIntArray([int(cell.x + 1) + int(cell.y) * SCREEN_WIDTH,
			int(cell.x - 1) + int(cell.y) * SCREEN_WIDTH,
			int(cell.x) + int(cell.y + 1) * SCREEN_WIDTH,
			int(cell.x) + int(cell.y - 1) * SCREEN_WIDTH])

func _on_Button_pressed():
	var castles_available := 2 + randi() % 4 # 1 to 4 steps
	print("castles_available:", castles_available)
	var global_path := PoolVector2Array()
	var last_index:Vector2 = $TileMap.world_to_map($RandomWalker.position)
	while castles_available > 0:
		var random_index := randi() % castles.size()
		var tile_index = castles[random_index]
		var path := _get_path(last_index, tile_index)
		for index in range(path.size()):
			if castles_available == 0:
				break
			var cell = path[index]
			var cell_index:Vector2 = $TileMap.world_to_map(cell)
			var cell_type:int = $TileMap.get_cellv(cell_index)
			if cell_type == 5:
				castles_available -= 1
			global_path.append(cell)
			last_index = cell_index
	$RandomWalker.move_along_the_path(global_path)