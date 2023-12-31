extends Node2D

# Ideas:
# IDEA: (maybe) Add 3, 2, 1 countdown that would go where the restart button is
# IDEA: (maybe) Missions return option on win / lose mission screen
# IDEA: (maybe) Mission loss shows winning emoji with angry squigly above (charlie brown thing)
# IDEA: (maybe) Pause functionality / menu for gameplay

# Get To-Do List:
# TODO: Total star count in top right corner of mission menu
# TODO: Random Seed for generating more mission levels and / or survival levels
# TODO: Anthropomorphic RPS anime chars b/c why not?
# TODO: Random survival backgrounds?
# TODO: Research for Godot Ad Banners - or kofi donations
# TODO: (Focus) [Cleanup] Backgrounds, 1-4, 5-7, 8-11 specific patterns?
# TODO: (Focus) [Cleanup] Level designs and difficulty scaling, random seeding?
# TODO: [Bug] Unit targeting mechanics: sometimes jittery, sometimes does not lock on targets
# TODO: Tutorial "level" and / or splash screen.
# TODO: (Done) Implement star scoring system - total ink used? - stay conservative!
# TODO: (Done) Stars earned animation/sfx on win state screen
# TODO: Finish background tscn file cropping and setting up
# TODO: Figure out deploying to iOS given all the hurdles..

# These vars should be set when instatiating the scene.
var mission_id = "00"
var game_mode = "survival" # | "mission"

# Undetermined when this would be set
var full_ink_meter_value = 1000
var max_star_ink_value = 4000.0
var star_ink_value = 4000.0
var star_color

# These get set in the scene implementation
var target_winning_unit = "rock" # | "paper" | "scissors"
var total_rock_count: int = 0
var total_scissors_count: int = 0
var total_paper_count: int = 0

# survival specific
var survival_win_streak = 0

# vars for seed maniputation
var rand_rock_x_min = 0
var rand_rock_x_max = 1080
var rand_rock_y_min = 0
var rand_rock_y_max = 1920
var rand_scissors_x_min = 0
var rand_scissors_x_max = 1080
var rand_scissor_y_min = 0
var rand_scissor_y_max = 1920
var rand_paper_x_min = 0
var rand_paper_x_max = 1080
var rand_paper_y_min = 0
var rand_paper_y_max = 1920

const main_menu_scene = "res://scenes/main_menu/main_menu.tscn"
const field_unit_scene = preload("res://objects/field_unit/field_unit.tscn")

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

var rng_seed

func _ready():
	star_color = $star1.modulate
	print(mission_id)
	print(game_mode)
	reset_game_state()
	
	Music.PlayLevelMusic()

func set_pregame_state():
	$winning_unit.visible = true
	$unit_wins_label.visible = true
	$description_label.visible = true
	$level_label.visible = true
	
	if target_winning_unit == "rock":
		$unit_wins_label.text = "Rock must win!"
		$winning_unit.texture = rock_texture
		$target_unit.texture = rock_texture
	if target_winning_unit == "paper":
		$unit_wins_label.text = "Paper must win!"
		$winning_unit.texture = paper_texture
		$target_unit.texture = paper_texture
	if target_winning_unit == "scissors":
		$unit_wins_label.text = "Scissors must win!"
		$winning_unit.texture = scissors_texture
		$target_unit.texture = scissors_texture
	
	if game_mode == "mission":
		$description_label.text = "MISSION"
		$level_label.text = mission_id
		$game_mode_label.text = "Mission %s" %[str(mission_id)]
		Utils.delete_children($background_container)
		$background_container.add_child(load(get_mission_background()).instantiate())
	if game_mode == "survival":
		$description_label.text = "SURVIVAL STREAK"
		$level_label.text = str(survival_win_streak)
		$game_mode_label.text = "Highscore: %s" %[str(DataStore.current.survival_highscore)]
		Utils.delete_children($background_container)
		# TODO: Random survival backgrounds?
		$background_container.add_child(load("res://backgrounds/starry_night/starry_night.tscn").instantiate())

func get_total_units() -> int:
	return total_rock_count + total_scissors_count + total_paper_count

func spawn_units(rock_count: int, scissors_count: int, paper_count: int):
	total_rock_count = rock_count
	total_paper_count = paper_count
	total_scissors_count = scissors_count
	
	var rng = RandomNumberGenerator.new()
	for i in range(0, rock_count):
		create_field_unit('rock', Vector2(rng.randf_range(rand_rock_x_min, rand_rock_x_max), rng.randf_range(rand_rock_y_min, rand_rock_y_max)))
	for i in range(0, scissors_count):
		create_field_unit('scissors', Vector2(rng.randf_range(rand_scissors_x_min, rand_scissors_x_max), rng.randf_range(rand_scissor_y_min, rand_scissor_y_max)))
	for i in range(0, paper_count):
		create_field_unit('paper', Vector2(rng.randf_range(rand_paper_x_min, rand_paper_x_max), rng.randf_range(rand_paper_y_min, rand_paper_y_max)))

func create_field_unit(unit_type: String, pos: Vector2):
	var new_field_unit = field_unit_scene.instantiate()
	new_field_unit.unit_type = unit_type
	new_field_unit.field_units_group = %field_unit_container
	new_field_unit.position = pos
	new_field_unit.field_unit_type_update.connect(_on_field_unit_type_update)
	%field_unit_container.call_deferred("add_child", new_field_unit)
		
func _on_field_unit_type_update():
	if GameplayVars.current_scissors_count == get_total_units():
		$winning_unit.texture = scissors_texture
		set_endgame_state("Scissors Wins", "scissors")
	
	if GameplayVars.current_paper_count == get_total_units():
		$winning_unit.texture = paper_texture
		set_endgame_state("Paper Wins", "paper")
	
	if GameplayVars.current_rock_count == get_total_units():
		$winning_unit.texture = rock_texture
		set_endgame_state("Rock Wins", "rock")

func set_endgame_state(unit_wins_text: String, winning_unit: String):
	if target_winning_unit == winning_unit:
		set_win_state()
	else:
		set_lose_state()
		
	$description_label.visible = true
	$winning_unit.visible = true
	$unit_wins_label.visible = true
	$main_menu_button.visible = true
	$next_button.visible = true
	$unit_wins_label.text = unit_wins_text
	$game_start_timer.stop()
	print(unit_wins_text)

func set_survival_highscore():
	if DataStore.current.survival_highscore < survival_win_streak:
		DataStore.current.survival_highscore = survival_win_streak
		DataStore.save()
		$game_mode_label.text = "Highscore: %s" %[str(DataStore.current.survival_highscore)]
	
	print("survival highscore = %s" %[str(DataStore.current.survival_highscore)])

func set_win_state():
	$description_label.text = "Congratulations!"
	
	if game_mode == "survival":
		survival_win_streak += 1
		$restart_button.visible = false
		$next_button.disabled = false
		set_survival_highscore()
	if game_mode == "mission":
		$restart_button.visible = true
		determine_stars_achieved()
		DataStore.save() # Need to save new proc gen level stars here
		if get_next_mission():
			DataStore.current.missions[get_next_mission()].locked = false
			$next_button.disabled = DataStore.current.missions[get_next_mission()].locked
		else:
			$next_button.disabled = true

func star2_tween(stars_achieved: int):
	var tween = create_tween()
	tween.tween_property($star2, "modulate", star_color, 0.5)
	tween.tween_property($star2, "modulate:a", 1, 0.5)
	tween.play()
	if stars_achieved > 2:
		tween.tween_callback(star3_tween)

func star3_tween():
	var tween = create_tween()
	tween.tween_property($star3, "modulate", star_color, 0.5)
	tween.tween_property($star3, "modulate:a", 1, 0.5)
	tween.play()

func stars_anim(stars_achieved: int):
	var tween = create_tween()
	tween.tween_property($star1, "modulate", star_color, 0.5)
	tween.tween_property($star1, "modulate:a", 1, 0.5)
	tween.play()
	if stars_achieved > 1:
		tween.tween_callback(star2_tween.bind(stars_achieved))

func determine_stars_achieved():
	$star1.visible = true
	$star1.modulate = Color(0, 0, 0, 0.5)
	$star2.visible = true
	$star2.modulate = Color(0, 0, 0, 0.5)
	$star3.visible = true
	$star3.modulate = Color(0, 0, 0, 0.5)
	
	var previous_stars_achieved = DataStore.current.missions[mission_id].stars
	var current_stars_achieved = 0
	
	if star_ink_value > max_star_ink_value * 2/3:
		current_stars_achieved = 3
	elif star_ink_value > max_star_ink_value * 1/3:
		current_stars_achieved = 2
	else:
		current_stars_achieved = 1
	
	stars_anim(current_stars_achieved)
	
	if current_stars_achieved > previous_stars_achieved:
		DataStore.current.missions[mission_id].stars = current_stars_achieved
		DataStore.save()

func set_lose_state():
	$description_label.text = "You failed..."
	$restart_button.visible = true
	
	if game_mode == "survival":
		$next_button.disabled = true
		set_survival_highscore()
	if game_mode == "mission":
		if get_next_mission():
			$next_button.disabled = DataStore.current.missions[get_next_mission()].locked
		else:
			$next_button.disabled = true

func get_next_mission():
	var mission_number := int(mission_id) + 1
	var next_mission = ""
	if mission_number < 10:
		next_mission += "0"
	next_mission += str(mission_number)
	return next_mission

func get_mission_background():
	if RefData.mission_level_data.has(mission_id) && RefData.mission_level_data[mission_id].has("background"):
		return RefData.mission_level_data[mission_id].background
	else:
		var dirs := DirAccess.get_directories_at("res://backgrounds/")
		var dirName = dirs[int(mission_id) % dirs.size()]
		var dir := DirAccess.open("res://backgrounds/" + dirName)
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if fileName.ends_with(".tscn"):
				return "res://backgrounds/" + dirName + "/" + fileName
			fileName = dir.get_next()
		
		return "res://backgrounds/starry_night/starry_night.tscn"

func delete_field_units():
	for unit in $field_unit_container.get_children():
		$field_unit_container.remove_child(unit)
		unit.queue_free()

func spawn_mission_units(_mission_id: String):
	if RefData.mission_level_data.has(_mission_id):
		var level_data = RefData.mission_level_data[_mission_id].level
		var unit_pos_y = 50
		var unit_pos_x = 50
		
		for r in range(level_data.size()):
			unit_pos_y += 90
			unit_pos_x = 50
			
			for c in range(level_data[r].size()):
				if level_data[r][c] == "r":
					create_field_unit("rock", Vector2(unit_pos_x, unit_pos_y))
					total_rock_count += 1
				if level_data[r][c] == "p":
					create_field_unit("paper", Vector2(unit_pos_x, unit_pos_y))
					total_paper_count += 1
				if level_data[r][c] == "s":
					create_field_unit("scissors", Vector2(unit_pos_x, unit_pos_y))
					total_scissors_count += 1
					
				unit_pos_x += 110
	else:
		#fancy proc gen here
		#stamp circles, squares, lines, and outlines onto the board
		#maybe occassionally mirror the board after gen?
		#rare star stamp
		#rarer stick figure stamp
		for i in 10: #completely temp
			for j in 3:
				match j:
					0:
						create_field_unit("rock", Vector2(
							seeded_rng() % 1040,
							seeded_rng() % 1760,))
						total_rock_count += 1
					1:
						create_field_unit("paper", Vector2(
							seeded_rng() % 1040,
							seeded_rng() % 1760,))
						total_paper_count += 1
					2:
						create_field_unit("scissors", Vector2(
							seeded_rng() % 1040,
							seeded_rng() % 1760,))
						total_scissors_count += 1
			

func set_target_winning_unit(_mission_id: String):
	if RefData.mission_level_data.has(_mission_id):
		target_winning_unit = RefData.mission_level_data[_mission_id].target_winning_unit
	else:
		match(int(mission_id) % 3):
			0:
				target_winning_unit = "rock"
			1:
				target_winning_unit = "paper"
			2:
				target_winning_unit = "scissors"

func set_random_target_winning_unit():
	var dice_roll = randi_range(0, 2)
	
	if dice_roll == 0:
		target_winning_unit = "rock"
	if dice_roll == 1:
		target_winning_unit = "paper"
	if dice_roll == 2:
		target_winning_unit = "scissors"

func reset_game_state():
	total_rock_count = 0
	total_paper_count = 0
	total_scissors_count = 0
	rng_seed = int(mission_id)
	
	if game_mode == "mission":
		star_ink_value = max_star_ink_value
		spawn_mission_units(mission_id)
		set_target_winning_unit(mission_id)
	if game_mode == "survival":
		spawn_units(25, 25, 25) # these values should be somewhat random
		set_random_target_winning_unit()
		
	print("target winning unit = %s" %[str(target_winning_unit)])

	$ink_meter.value = full_ink_meter_value
	GameplayVars.ink_meter_value = full_ink_meter_value
	GameplayVars.current_rock_count = total_rock_count
	GameplayVars.current_paper_count = total_paper_count
	GameplayVars.current_scissors_count = total_scissors_count
#	$winning_unit.visible = false
#	$unit_wins_label.visible = false
	$description_label.visible = false
	$main_menu_button.visible = false
	$restart_button.visible = false
	$next_button.visible = false
	
	$star1.visible = false
	$star2.visible = false
	$star3.visible = false
	set_pregame_state()
	
	$game_start_timer.start()

func _on_restart_button_pressed():
	survival_win_streak = 0
	delete_field_units()
	reset_game_state()

func _on_player_cursor_draw_ink(amount):
	star_ink_value -= amount
	GameplayVars.ink_meter_value -= amount
	$ink_meter.value -= amount

func _on_player_cursor_reset_ink_meter():
	GameplayVars.ink_meter_value = full_ink_meter_value
	$ink_meter.value = full_ink_meter_value

func _on_main_menu_button_pressed():
	SceneSwitcher.change_to_scene(main_menu_scene)

func _on_next_button_pressed():
	if game_mode == "survival":
		delete_field_units()
		reset_game_state()
	if game_mode == "mission":
		mission_id = get_next_mission()
		delete_field_units()
		reset_game_state()

func _on_game_start_timer_timeout():
	$winning_unit.visible = false
	$unit_wins_label.visible = false
	$description_label.visible = false
	$level_label.visible = false

func seeded_rng():
	rng_seed = rand_from_seed(rng_seed)[0]
	return rng_seed
