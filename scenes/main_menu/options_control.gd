extends Control

const options_menu_scene = "res://scenes/options_menu/options_menu.tscn"


func open_options():
	SceneSwitcher.change_to_scene(options_menu_scene)


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			open_options()
