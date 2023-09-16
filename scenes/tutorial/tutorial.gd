extends Control

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

func _on_back_button_pressed():
	SceneSwitcher.change_to_scene(main_menu_scene)
