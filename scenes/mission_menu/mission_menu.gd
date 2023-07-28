extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
var main_menu_scene = "res://scenes/main_menu/main_menu.tscn"
var ui_theme = preload("res://assets/themes/ui_theme.tres")

func _ready():
	create_mission_buttons()
	$mission_01.visible = false

func create_mission_buttons():
	var button_pos_y = -75
	var button_pos_x = 65
	var mission_number = 0
	
	for r in range(7):
		button_pos_y += 250
		button_pos_x = 65
		
		for c in range(4):
			var button_text = ""
			mission_number += 1
			
			if mission_number < 10:
				button_text += "0"
				button_text += str(mission_number)
			else:
				button_text += str(mission_number)
				
			create_mission_button(Vector2(button_pos_x, button_pos_y), button_text)
			button_pos_x += 250

func create_mission_button(pos: Vector2, text: String):
	var button_height = 200
	var button_length = 200
	var new_mission_button = Button.new()
	new_mission_button.set_position(pos)
	new_mission_button.set_size(Vector2(button_length, button_height))
	new_mission_button.theme = ui_theme
	new_mission_button.text = text
	new_mission_button.pressed.connect(on_mission_button_pressed.bind(text))
	self.add_child(new_mission_button)

func on_mission_button_pressed(mission_text: String):
	print(mission_text)

func change_to_scene(scene: String):
	get_tree().change_scene_to_file(scene)

func _on_mission_01_pressed():
	change_to_scene(gameplay_scene)

func _on_back_button_pressed():
	change_to_scene(main_menu_scene)
