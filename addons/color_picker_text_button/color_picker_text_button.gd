tool
extends Button

signal popup_hide
signal color_changed(color)

export var text_value = "Click Me" setget set_label_text
export(StyleBoxFlat) var style setget set_styles
export(float, 0.1, 0.8) var mouseover_darkening_factor = 0.1
export(DynamicFont) var custom_font
export(Color) var color
export(Color) var light_text_color = Color.white
export(Color) var dark_text_color = Color.black
export(float, 0.2, 0.8) var text_color_flip_threshold = 0.5
export var popup_centered = true
export var simple_color_picker = true
export var enable_text = true setget show_hide_label

var panel
var color_picker
var center
var label


func _ready():
	# Add panel with color picker
	panel = PopupPanel.new()
	add_child(panel)
	color_picker = ColorPicker.new()
	color_picker.color = color
	panel.add_child(color_picker)

	# Connect signals
	var _e = connect("pressed", self, "show_panel")
	_e = color_picker.connect("color_changed", self, "set_colors")
	_e = panel.connect("popup_hide", self, "panel_closed")

	if simple_color_picker:
		# Hide color picker elements
		for n in range(3, color_picker.get_child_count()):
			color_picker.get_child(n).hide()

	# Make panel resize to fit contents
	panel.rect_size.y = 0 # Make panel resize to fit contents

	# Initially style the button
	if Engine.editor_hint:
		self.style = load("res://addons/color_picker_text_button/styleboxflat.tres")
		rect_position = Vector2(20, 10)
		color = Color.white

	setup_label()


func setup_label():
	center = CenterContainer.new()
	add_child(center)
	label = Label.new()
	center.add_child(label)
	if custom_font:
		label.set("custom_fonts/font", custom_font)
	call_deferred("init_size")
	label.text = text_value
	text = ""
	set_colors(color)
	center.mouse_filter = MOUSE_FILTER_PASS
	center.visible = enable_text


func show_hide_label(show_text):
	enable_text = show_text
	center.visible = enable_text


func init_size():
	rect_size = Vector2(200, 60)
	center.rect_size = rect_size


func set_styles(s):
	style = s
	if style == null:
		style = get("custom_styles/normal")
		if style == null:
			return # Stick with default button style
	else:
		set("custom_styles/normal", style)
	var next_style = set_style(style, "custom_styles/hover")
	next_style = set_style(next_style, "custom_styles/pressed")


func set_style(current_style, path):
	var new_style = get(path)
	if new_style == null:
		new_style = current_style.duplicate()
		new_style.bg_color = new_style.bg_color.darkened(mouseover_darkening_factor)
		set(path, new_style)
	return new_style


func set_label_text(txt):
	text_value = txt
	text = ""
	if Engine.editor_hint and label:
		# Export setter is called before the _ready() function when running scene.
		label.text = txt


func show_panel():
	if popup_centered:
		panel.popup_centered()
	else:
		panel.popup()


func panel_closed():
	release_focus()
	emit_signal("popup_hide")


func set_colors(c):
	emit_signal("color_changed", c)
	self_modulate = c
	color = c
	var grey_value = (c.r + c.g + c.b) / 3
	if grey_value > text_color_flip_threshold:
		label.set("custom_colors/font_color", dark_text_color)
	else:
		label.set("custom_colors/font_color", light_text_color)
