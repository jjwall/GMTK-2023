extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
var missions_menu_scene = "res://scenes/mission_menu/mission_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_survival_button_pressed():
	var gameplay = SceneSwitcher.change_to_scene(gameplay_scene)
	gameplay.game_mode = "survival" 

func _on_missions_button_pressed():
	SceneSwitcher.change_to_scene(missions_menu_scene)
