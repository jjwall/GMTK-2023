extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
var missions_menu_scene = "res://scenes/mission_menu/mission_menu.tscn"
var tutorial_scene = "res://scenes/tutorial/tutorial.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db(DataStore.current.sfx_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(DataStore.current.music_volume))
	
	Music.PlayMainMusic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_survival_button_pressed():
	var gameplay = SceneSwitcher.change_to_scene(gameplay_scene)
	gameplay.game_mode = "survival" 

func _on_missions_button_pressed():
	SceneSwitcher.change_to_scene(missions_menu_scene)

func _on_tutorial_button_pressed():
	SceneSwitcher.change_to_scene(tutorial_scene)
