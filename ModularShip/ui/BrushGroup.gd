tool
extends VBoxContainer

export(String) var title: String setget _set_title
export(int, 1, 2) var brush_width := 1 setget _set_brush_width
export(int, 1, 4) var brush_height := 1 setget _set_brush_height
export(Array, Texture) var buttons: Array setget _set_buttons

onready var title_label: Label = $Title
onready var button_container: GridContainer = $ButtonContainer

var ready := false

func _ready():
	ready = true

func _set_title(value: String):
	if not ready:
		yield(self, "ready")
	title = value
	title_label.text = value

func _set_brush_width(value: int):
	brush_width = value
	
	if not ready:
		yield(self, "ready")
	
	# Assuming, brush width can only be 1 or 2
	var separation = 2 * brush_width
	button_container.columns = 6 / brush_width
	button_container.set("custom_constants/vseparation", separation)
	button_container.set("custom_constants/hseparation", separation)

func _set_brush_height(value: int):
	brush_height = value
	
	if not ready:
		yield(self, "ready")
	
	for child in button_container.get_children():
		# 8 is min size, 2 is scale.
		child.rect_min_size = Vector2(0, 16 * brush_height)

func _set_buttons(value: Array):
	if not ready:
		yield(self, "ready")
	buttons = value
	for child in button_container.get_children():
		child.queue_free()
	for button_texture in buttons:
		var button := TextureButton.new()
		button.texture_normal = button_texture
		button.add_to_group("brush_button")
		button.rect_min_size = Vector2(16 * brush_width, 16 * brush_height)
		button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT
		button.expand = true
		button_container.add_child(button)
		button.owner = button_container
