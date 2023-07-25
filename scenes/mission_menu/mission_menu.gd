extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_to_gameplay_scene():
	get_tree().change_scene_to_file(gameplay_scene)


func _on_mission_01_pressed():
	change_to_gameplay_scene()
