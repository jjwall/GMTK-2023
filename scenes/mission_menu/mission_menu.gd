extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
var main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_to_scene(scene: String):
	get_tree().change_scene_to_file(scene)

func _on_mission_01_pressed():
	change_to_scene(gameplay_scene)

func _on_back_button_pressed():
	change_to_scene(main_menu_scene)
