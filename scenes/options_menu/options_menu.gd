# TODO: Add Music - main menu, gameplay
# TODO: Implement No Ad purchase
# TODO: Restore Purchases for iOS - needs R&D
# TODO: SFX:
# -> Drawwing line
# -> Paper ruffle
# -> Scissors snip
# -> Rock crush
# -> Star twinkle
# -> Button click
# -> Succeeded mission sound
# -> Failed mission sound
# TODO: Music
# -> Menu
# -> Mission
# -> Survival

extends Control

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

var sfx_test_sound : AudioStreamPlayer

func _ready():
	# TODO: Remove disabled, implement no ad purchase for iOS & Android.
	$no_ads_button.disabled = true
	
	sfx_test_sound = $pop_sfx
	$credits_modal.visible = false
	$delete_data_modal.visible = false
	$data_deleted_banner.visible = false
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
	$data_deleted_banner.visible = true
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
	tween.tween_callback(on_banner_fade_end)
	
func on_banner_fade_end():
	$data_deleted_banner.visible = false

func _on_music_volume_slider_drag_ended(_value_changed):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db($music_volume_slider.value))
	DataStore.current.music_volume = $music_volume_slider.value
	DataStore.save()

func _on_sfx_volume_slider_drag_ended(_value_changed):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db($sfx_volume_slider.value))
	sfx_test_sound.play()
	DataStore.current.sfx_volume = $sfx_volume_slider.value
	DataStore.save()

func _on_credits_button_pressed():
	$credits_modal.visible = true

func _on_credits_back_button_pressed():
	$credits_modal.visible = false

func _on_unlock_button_pressed():
	DataStore.unlock_all_levels()
