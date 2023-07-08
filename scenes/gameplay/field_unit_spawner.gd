extends Node

@export var rock_count: int = 25
@export var scissors_count: int = 25
@export var paper_count: int = 25

var field_unit_scene = preload("res://objects/field_unit/field_unit.tscn")

func _ready():
	spawn_units()
		
func spawn_units():
	var rng = RandomNumberGenerator.new()
	for i in range(0, rock_count - 1):
		var new_rock_unit = field_unit_scene.instantiate()
		new_rock_unit.type = 'rock'
#		new_rock_unit.linear_velocity = Vector2(rng.randf_range(-75, 0), rng.randf_range(-75, 75))
		new_rock_unit.position = Vector2(rng.randf_range(500, 600), rng.randf_range(-300, 300))
		%field_unit_container.call_deferred("add_child", new_rock_unit)
	for i in range(0, scissors_count - 1):
		var new_scissors_unit = field_unit_scene.instantiate()
		new_scissors_unit.type = 'scissors'
#		new_scissors_unit.linear_velocity = Vector2(rng.randf_range(-75, 0), rng.randf_range(-75, 75))
		new_scissors_unit.position = Vector2(rng.randf_range(500, 600), rng.randf_range(-300, 300))
		%field_unit_container.call_deferred("add_child", new_scissors_unit)
	for i in range(0, paper_count - 1):
		var new_paper_unit = field_unit_scene.instantiate()
		new_paper_unit.type = 'paper'
#		new_paper_unit.linear_velocity = Vector2(rng.randf_range(-75, 0), rng.randf_range(-75, 75))
		new_paper_unit.position = Vector2(rng.randf_range(500, 600), rng.randf_range(-300, 300))
		%field_unit_container.call_deferred("add_child", new_paper_unit)

#func _on_trash_collector_body_entered(body: Node):
#	if body.get_parent().name == "trash_container":
#		body.queue_free()
#
#func _on_spawn_trash_timer_timeout():
#	spawn_trash()


