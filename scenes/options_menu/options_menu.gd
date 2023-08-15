extends Control

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

func _ready():
	$sfx_volume_slider.value = DataStore.current.sfx_volume
	$music_volume_slider.value = DataStore.current.music_volume

func _on_back_button_pressed():
	SceneSwitcher.change_to_scene(main_menu_scene)

func _on_delete_data_button_pressed():
	DataStore.delete_data()
	$sfx_volume_slider.value = DataStore.current.sfx_volume
	$music_volume_slider.value = DataStore.current.music_volume
