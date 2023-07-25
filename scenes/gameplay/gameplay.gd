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
	spawn_units()
	GameplayVars.current_rock_count = rock_count
	GameplayVars.current_paper_count = paper_count
	GameplayVars.current_scissors_count = scissors_count
		
func spawn_units():
	var rng = RandomNumberGenerator.new()
	for i in range(0, rock_count):
		var new_rock_unit = field_unit_scene.instantiate()
		new_rock_unit.unit_type = 'rock'
		new_rock_unit.field_units_group = %field_unit_container
		new_rock_unit.position = Vector2(rng.randf_range(rand_rock_x_min, rand_rock_x_max), rng.randf_range(rand_rock_y_min, rand_rock_y_max))
		new_rock_unit.field_unit_type_update.connect(_on_field_unit_type_update)
		%field_unit_container.call_deferred("add_child", new_rock_unit)
	for i in range(0, scissors_count):
		var new_scissors_unit = field_unit_scene.instantiate()
		new_scissors_unit.unit_type = 'scissors'
		new_scissors_unit.field_units_group = %field_unit_container
		new_scissors_unit.position = Vector2(rng.randf_range(rand_scissors_x_min, rand_scissors_x_max), rng.randf_range(rand_scissor_y_min, rand_scissor_y_max))
		new_scissors_unit.field_unit_type_update.connect(_on_field_unit_type_update)
		%field_unit_container.call_deferred("add_child", new_scissors_unit)
	for i in range(0, paper_count):
		var new_paper_unit = field_unit_scene.instantiate()
		new_paper_unit.unit_type = 'paper'
		new_paper_unit.field_units_group = %field_unit_container
		new_paper_unit.position = Vector2(rng.randf_range(rand_paper_x_min, rand_paper_x_max), rng.randf_range(rand_paper_y_min, rand_paper_y_max))
		new_paper_unit.field_unit_type_update.connect(_on_field_unit_type_update)
		%field_unit_container.call_deferred("add_child", new_paper_unit)
		
func _on_field_unit_type_update():
	if GameplayVars.current_scissors_count == total_units_count:
		print("Scissors Wins")
	
	if GameplayVars.current_paper_count == total_units_count:
		print("Paper Wins")
		
	if GameplayVars.current_rock_count == total_units_count:
		print("Rock Wins")
