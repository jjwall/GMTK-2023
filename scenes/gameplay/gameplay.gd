extends Node2D

@export var rock_count: int = 25
@export var scissors_count: int = 25
@export var paper_count: int = 25
var total_units_count = rock_count + scissors_count + paper_count

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

var field_unit_scene = preload("res://objects/field_unit/field_unit.tscn")

func _ready():
	GameplayVars.current_rock_count = rock_count
	GameplayVars.current_paper_count = paper_count
	GameplayVars.current_scissors_count = scissors_count
	spawn_units()

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
		print("Scissors Wins")
	
	if GameplayVars.current_paper_count == total_units_count:
		print("Paper Wins")
		
	if GameplayVars.current_rock_count == total_units_count:
		print("Rock Wins")
