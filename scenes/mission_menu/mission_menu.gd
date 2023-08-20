extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"

const locked_emoji_texture = preload("res://assets/textures/locked_microsoft_emoji.png")
const star_emoji_texture = preload("res://assets/textures/star_microsoft_emoji.png")
const ui_theme = preload("res://assets/themes/ui_theme.tres")

func _ready():
	# Create mission buttons grid.
	create_mission_buttons()
	process_total_stars()

func process_total_stars():
	var total_stars = 0
	for n in DataStore.current.missions:
		var current_mission_id = str(n)
		total_stars += DataStore.current.missions[current_mission_id].stars
	
	$total_star_label.text = str(total_stars)

func create_mission_buttons():
	var button_pos_y = -75
	var button_pos_x = 65
	var mission_number = 0
	
	for r in range(7):
		button_pos_y += 250
		button_pos_x = 65
		
		for c in range(4):
			var mission_id = ""
			mission_number += 1
			
			if mission_number < 10:
				mission_id += "0"
				mission_id += str(mission_number)
			else:
				mission_id += str(mission_number)
				
			create_mission_button(Vector2(button_pos_x, button_pos_y), mission_id)
			button_pos_x += 250

func create_mission_button(pos: Vector2, mission_id: String):
	var button_height = 200
	var button_length = 200
	var new_mission_button = Button.new()
	new_mission_button.set_position(pos)
	new_mission_button.set_size(Vector2(button_length, button_height))
	new_mission_button.theme = ui_theme
	new_mission_button.text = mission_id
	new_mission_button.pressed.connect(on_mission_button_pressed.bind(mission_id))
	self.add_child(new_mission_button)
	
	if DataStore.current.missions.has(mission_id):
		if DataStore.current.missions[mission_id].locked:
			# Disable button and add lock emoji if locked.
			new_mission_button.disabled = true
			pos.x -= 25
			pos.y += 95
			add_locked_emoji(pos)
		else: # Mission unlocked and potentially already played.
			# Render amount of stars earned for mission.
			var star_count = DataStore.current.missions[mission_id].stars
			for s in range(3):
				if star_count >= s + 1:
					add_star_emoji(pos)
				else: # Missing a star
					add_star_emoji(pos, true)
				
				pos.x += 65

func add_star_emoji(pos: Vector2, empty: bool = false):
	var star_emoji = TextureRect.new()
	star_emoji.texture = star_emoji_texture
	star_emoji.set_position(pos)
	star_emoji.set_scale(Vector2(0.3, 0.3))
	
	if empty:
		star_emoji.modulate = Color(0, 0, 0, 0.5)
		
	self.add_child(star_emoji)

func add_locked_emoji(pos: Vector2):
	var locked_emoji = TextureRect.new()
	locked_emoji.texture = locked_emoji_texture
	locked_emoji.set_position(pos)
	locked_emoji.set_scale(Vector2(0.4, 0.4))
	self.add_child(locked_emoji)

func on_mission_button_pressed(mission_id: String):
	if DataStore.current.missions.has(mission_id):
		# TODO: Pass mission level data to scene.
		var new_gameplay_scene = SceneSwitcher.change_to_scene(gameplay_scene)
		new_gameplay_scene.mission_id = mission_id
		new_gameplay_scene.game_mode = "mission"
		print(DataStore.current.missions[mission_id])
	else:
		print("Mission %s is not in data store" % mission_id)

func _on_back_button_pressed():
	SceneSwitcher.change_to_scene(main_menu_scene)
