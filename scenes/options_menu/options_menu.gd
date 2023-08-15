# TODO: Credits
# TODO: Implement sound volume changing
# TODO: Save volume slider values on change
# TODO: (Done) Data deleted banner
# TODO: Implement No Ad purchase

extends Control

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

func _ready():
	$delete_data_modal.visible = false
	$data_deleted_banner.modulate.a = 0
	$sfx_volume_slider.value = DataStore.current.sfx_volume
	$music_volume_slider.value = DataStore.current.music_volume

func _on_back_button_pressed():
	SceneSwitcher.change_to_scene(main_menu_scene)

func _on_delete_data_button_pressed():
	$delete_data_modal.visible = true

func _on_delete_button_pressed():
	DataStore.delete_data()
	$sfx_volume_slider.value = DataStore.current.sfx_volume
	$music_volume_slider.value = DataStore.current.music_volume
	$delete_data_modal.visible = false
	$data_deleted_banner.modulate.a = 1
	$banner_timer.start()

func _on_cancel_button_pressed():
	$delete_data_modal.visible = false

func _on_banner_timer_timeout():
	fade_banner_out()

func fade_banner_out():
	# Note: Tween doesn't reset so banner only shows up once.
	var tween = create_tween()
	tween.tween_property($data_deleted_banner, "modulate:a", 0, 1)
