extends Control

const options_menu_scene = "res://scenes/options_menu/options_menu.tscn"

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			open_options()
	
func open_options():
	SceneSwitcher.change_to_scene(options_menu_scene)
