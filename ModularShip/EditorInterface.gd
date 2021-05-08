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
	if OS.get_name() == "HTML5":
		JavaScript.eval("""
		function download(fileName, byte, type) {
			var buffer = Uint8Array.from(byte);
			var blob = new Blob([buffer], { type: type});
			var link = document.createElement('a');
			link.href = window.URL.createObjectURL(blob);
			link.download = fileName;
			link.click();
		};
		""", true)

func _on_brush_selected(texture: AtlasTexture):
	editor.set_brush(texture)


func _on_Flip_toggled(button_pressed):
	editor.flip_tile = button_pressed


func _on_SavePngDialog_file_selected(path):
	path += ".png"
	editor.hide_cursor()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var texture_data: Image = viewport.get_texture().get_data()
	texture_data.flip_y()
	var min_x := texture_data.get_width()
	var min_y := texture_data.get_height()
	var max_x := 0
	var max_y := 0
	texture_data.lock()
	for x in range(texture_data.get_width()):
		for y in range(texture_data.get_height()):
			var color := texture_data.get_pixel(x, y)
			if color.a != 0:
				min_x = min(min_x, x)
				min_y = min(min_y, y)
				max_x = max(max_x, x)
				max_y = max(max_y, y)
	texture_data.unlock()
	var rect = Rect2(min_x, min_y, max_x, max_y)
	texture_data = texture_data.get_rect(rect)
	texture_data.convert(Image.FORMAT_RGBA8)
	if OS.get_name() == "HTML5":
		var png_data = Array(texture_data.save_png_to_buffer())
		JavaScript.eval("download('%s', %s, 'image/png');" % ["Export", str(png_data)], true)
	else:
		texture_data.save_png(path)
	editor.show_cursor()


func _on_ExportButton_pressed():
	if OS.get_name() == "HTML5":
		_on_SavePngDialog_file_selected("ignored")
	else:
		$SavePngDialog.show()
