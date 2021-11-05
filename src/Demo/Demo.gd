extends Control


func _on_ColorPickerTextButton_popup_hide():
	print("Popup was hidden")


func _on_ColorPickerTextButton_color_changed(color):
	$ColorRect.color = color
