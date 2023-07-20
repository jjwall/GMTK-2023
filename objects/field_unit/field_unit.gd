extends RigidBody2D
# TODO: Levels
# TODO: Spawn clumping
# TODO: Player char unit
# TODO: Mobile view
# TODO: Click and drag wall creation

@export var unit_type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null

@export var imprecision = 4 #increase this number for more performance
var check_num = 0

var SPEED = 75
var target : RigidBody2D = null
var aimless_direction = null

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

var resolution_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var resolution_height = ProjectSettings.get_setting("display/window/size/viewport_height")

var sprite : Sprite2D
var target_search : Area2D
var sfx : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
#	connect("body_entered", Callable(self, "_on_body_entered"))
#	add_collision_exception_with(self)
	SPEED = randf_range(75, 125)
	sprite = $Sprite2D
	target_search = $TargetSearchArea
	sfx = $AudioStreamPlayer
	process_type_update()
	aimless_direction = Vector2((randf() * 2) - 1, (randf() * 2) - 1)

func _physics_process(delta):
	check_num += 1
	if check_num == imprecision:
		locate_target()
		check_num = 0
	
	if target:
		var direction = global_position.direction_to(target.position)
#		position += direction * SPEED * delta
		move_and_collide(direction * SPEED * delta)
	else:
#		position += aimless_direction * SPEED * delta
		move_and_collide(aimless_direction * SPEED * delta)
	
	wrap_position()

func wrap_position():
	if position.x > resolution_width:
		position.x = 0
	elif position.x < 0:
		position.x = resolution_width
	if position.y > resolution_height:
		position.y = 0
	elif position.y < 0:
		position.y = resolution_height

func locate_target():
#	var children = field_units_group.get_children()
	var children: Array[Node2D] = target_search.get_overlapping_bodies()
	if children.size() < 1:
		return
	var min_distance = 999999
	var min_node : RigidBody2D = null
	var current_distance = 9999999
	for i in range(0, children.size() - 1):
#		if children[i].is_in_group("field_units_group"):
			if children[i].unit_type == 'rock':
				if self.unit_type == 'paper':
					current_distance = position.distance_squared_to(children[i].position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = children[i]
			if children[i].unit_type == 'paper':
				if self.unit_type == 'scissors':
					current_distance = position.distance_squared_to(children[i].position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = children[i]
			if children[i].unit_type == 'scissors':
				if self.unit_type == 'rock':
					current_distance = position.distance_squared_to(children[i].position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = children[i]
	target = min_node


func process_collision(colliding_entity: RigidBody2D):
	add_collision_exception_with(colliding_entity)
	if unit_type == 'rock' && colliding_entity.unit_type == 'paper':
		unit_type = 'paper'
		process_type_update()
	if unit_type == 'paper' && colliding_entity.unit_type == 'scissors':
		unit_type = 'scissors'
		process_type_update()
	if unit_type == 'scissors' && colliding_entity.unit_type == 'rock':
		unit_type = 'rock'
		process_type_update()

func process_type_update():
	target = null
	locate_target()
	sfx.play()
	if unit_type == 'rock':
		sprite.texture = rock_texture
	elif unit_type == 'paper':
		sprite.texture = paper_texture
	else:
		sprite.texture = scissors_texture

#func on_collision(body):
#	print(body)
#	if body.is_in_group("field_units"):
#		process_collision(body)
#
#func _on_area_entered(area):
#	if area.is_in_group("field_units"):
#		process_collision(area)


func _on_body_entered(body):
	if body.is_in_group("line_points"):
		print("hi")
	if body.is_in_group("field_units"):
		process_collision(body)
