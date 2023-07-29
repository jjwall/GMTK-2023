extends Node2D

# Have target win condition (pick a unit to win)
# (Done) ink meter

@export var rock_count: int = 25
@export var scissors_count: int = 25
@export var paper_count: int = 25
var total_units_count = rock_count + scissors_count + paper_count

const full_ink_meter_value = 1000

# Instantiation vars
var mission_id = "00"

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

const field_unit_scene = preload("res://objects/field_unit/field_unit.tscn")

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

func _ready():
	print(mission_id)
	reset_game_state()

func spawn_units():
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
	if GameplayVars.current_scissors_count == total_units_count:
		$winning_unit.texture = scissors_texture
		set_win_state("Scissors Wins")
	
	if GameplayVars.current_paper_count == total_units_count:
		$winning_unit.texture = paper_texture
		set_win_state("Paper Wins")
	
	if GameplayVars.current_rock_count == total_units_count:
		$winning_unit.texture = rock_texture
		set_win_state("Rock Wins")

func set_win_state(unit_wins_text: String):
	$winning_unit.visible = true
	$unit_wins_label.visible = true
	$restart_button.visible = true
	$unit_wins_label.text = unit_wins_text
	print(unit_wins_text)

func delete_field_units():
	for unit in $field_unit_container.get_children():
		$field_unit_container.remove_child(unit)
		unit.queue_free()

func reset_game_state():
	spawn_units()
	$ink_meter.value = full_ink_meter_value
	GameplayVars.ink_meter_value = full_ink_meter_value
	GameplayVars.current_rock_count = rock_count
	GameplayVars.current_paper_count = paper_count
	GameplayVars.current_scissors_count = scissors_count
	$winning_unit.visible = false
	$unit_wins_label.visible = false
	$restart_button.visible = false

func _on_restart_button_pressed():
	delete_field_units()
	reset_game_state()

func _on_player_cursor_draw_ink(amount):
	GameplayVars.ink_meter_value -= amount
	$ink_meter.value -= amount

func _on_player_cursor_reset_ink_meter():
	GameplayVars.ink_meter_value = full_ink_meter_value
	$ink_meter.value = full_ink_meter_value
