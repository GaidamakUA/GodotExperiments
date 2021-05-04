extends Control

var colors := [Color.antiquewhite, Color.blue, Color.crimson, Color.black]
var last_color_index := 0

var angle_stack := PoolVector2Array()
var position_stack := PoolVector2Array()

var _initial_position: Vector2
var _previous_position: Vector2
var _commands : String
var _line: Vector2
export var inital_line := Vector2(0, -60)
export var angle := 45
export var step_size := 0.65

func plot(commands: String):
	_commands = commands
	var x = rect_size.x / 2
	var y = rect_size.y / 2# - 8
	_initial_position = Vector2(x, y)
	_line = inital_line
	update();

func _draw():
	_previous_position = _initial_position
	while _commands.length() > 0:
		var character = _commands.left(1)
		_commands = _commands.trim_prefix(character)
		print(character)
		if character == "F":
			var next_position = _previous_position + _line
			draw_line(_previous_position, next_position, _get_next_color())
			_previous_position = next_position
		if character == "G":
			var next_position = _previous_position + _line
			_previous_position = next_position
		elif character == "+":
			_line = _line.rotated(PI * angle / 180)
		elif character == "-":
			_line = _line.rotated(-PI * angle / 180)
		elif character == "[":
			angle_stack.append(_line)
			position_stack.append(_previous_position)
			print("push ", angle_stack)
		elif character == "]":
			_line = _pick_stack(angle_stack)
			angle_stack.resize(angle_stack.size() - 1)
			_previous_position = _pick_stack(position_stack)
			position_stack.resize(position_stack.size() - 1)
			print("pop ",angle_stack)
		elif character == "|":
			var next_position = _previous_position + _line
			draw_line(_previous_position, next_position, _get_next_color())
			_previous_position = next_position
			_line = _line * step_size

func _get_next_color() -> Color:
	last_color_index += 1
	var index := last_color_index % colors.size()
	return colors[index]

func _pick_stack(stack: PoolVector2Array) -> Vector2:
	var last_position = stack.size() - 1
	var value = stack[last_position]
	return value