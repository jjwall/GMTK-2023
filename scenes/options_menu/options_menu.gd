# TODO: (Done) Add Music - main menu, gameplay
# TODO: Implement No Ad purchase
# TODO: Restore Purchases for iOS - needs R&D
# TODO: SFX:
# -> Drawwing line
# -> Paper ruffle
# -> Scissors snip
# -> Rock crush
# -> (Done) Star twinkle
# -> Button click
# -> Succeeded mission sound
# -> Failed mission sound
# TODO: Music
# -> (Done) Menu
# -> (Done) Mission
# -> (Done) Survival

# From 08/22/2025:
# TODO: (It seems fine b/c you can unlock multiple levels at once) Consider not using star count i.e. "RefData.PageCount" for mission unlocks.
# -> This instead could just be if you beat previous level unlock next level.
# TODO: (Done) Set up mission page DataStore variable so you don't have to scroll through everytime you open the mission menu
# TODO: (Done) Main Menu button on mission mode should instead be Mission Menu and take you to that saved mission page.
# TODO: (Done) Fast forward button

extends Control

const audio_icon = preload("res://assets/textures/tempAudio.png")
const audio_icon_no_sound = preload("res://assets/textures/tempAudioNoSound.png")

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

var muted = false
var sfx_test_sound : AudioStreamPlayer
var payment

enum PurchaseState {
	UNSPECIFIED,
	PURCHASED,
	PENDING,
}

func _ready():
	sfx_test_sound = $pop_sfx
	$credits_modal.visible = false
	$delete_data_modal.visible = false
	$data_deleted_banner.visible = false
	$data_deleted_banner.modulate.a = 0
	$sfx_volume_slider.value = DataStore.current.sfx_volume
	$music_volume_slider.value = DataStore.current.music_volume
	
	muted = DataStore.current.mute_sound
	if muted:
		$mute_button.icon = audio_icon_no_sound
	else:
		$mute_button.icon = audio_icon
	
	if DataStore.current.ad_free_purchased:
		$premium_button.disabled = true
	
	if Engine.has_singleton("GodotGooglePlayBilling"):
		payment = Engine.get_singleton("GodotGooglePlayBilling")
		payment.connected.connect(_on_connected)
		payment.purchases_updated.connect(_on_purchases_updated)
		payment.startConnection()
	else:
		print("whoopsies")

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

func _on_connected(): # should match the SKU product id defined in the Google Play Console entry
	payment.querySkuDetails(["premium_purchase"], "inapp")

func _on_purchases_updated(purchases):
	for purchase in purchases:
		if purchase.purchase_state == PurchaseState.PURCHASED && !purchase.is_acknowledged:
			DataStore.current.ad_free_purchased = true
			DataStore.save()
			$premium_button.disabled = true
			payment.acknowledgePurchase(purchase.purchase_token)

func _on_premium_button_pressed() -> void:
	if payment.isReady():
		payment.purchase("premium_purchase")


func _on_mute_button_pressed() -> void:
	process_mute()
	DataStore.current.mute_sound = muted
	DataStore.save()
	
func process_mute():
	if muted:
		$mute_button.icon = audio_icon
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(DataStore.current.music_volume))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db(DataStore.current.sfx_volume))
		muted = false
	else:
		$mute_button.icon = audio_icon_no_sound
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), -80)
		muted = true
