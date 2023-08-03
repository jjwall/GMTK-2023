extends Control
#
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			open_options()
	
func open_options():
	print("scene switch to options")
