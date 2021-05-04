extends Control

export(NodePath) var editor_path
export(NodePath) var viewport_path
onready var editor: Editor = get_node(editor_path)
onready var viewport: Viewport = get_node(viewport_path)

func _ready():
	var buttons = get_tree().get_nodes_in_group("brush_button")
	for button in buttons:
		var texture = [button.texture_normal]
		button.connect("pressed", self, "_on_brush_selected", texture)


func _on_brush_selected(texture: AtlasTexture):
	editor.set_brush(texture)


func _on_Flip_toggled(button_pressed):
	editor.flip_tile = button_pressed


func _on_SavePngDialog_file_selected(path):
	var texture_data = viewport.get_texture().get_data()
	texture_data.save_png(path)


func _on_ExportButton_pressed():
	$SavePngDialog.show()
