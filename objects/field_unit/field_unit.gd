extends Area2D

@export var type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null

@export var imprecision = 4 #increase this number for more performance
var check_num = 0

var SPEED = 75
var target : Area2D = null
var aimless_direction = null

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

var sprite : Sprite2D
var target_search : Area2D
var sfx : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
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
		position += direction * SPEED * delta
	else:
		position += aimless_direction * SPEED * delta
	
	if position.x > 1280:
		position.x = 0
	elif position.x < 0:
		position.x = 1280
	if position.y > 720:
		position.y = 0
	elif position.y < 0:
		position.y = 720

func locate_target():
#	var children = field_units_group.get_children()
	var children = target_search.get_overlapping_areas()
	if children.size() < 1:
		return
	var min_distance = 999999
	var min_node : Area2D = null
	var current_distance = 9999999
	for i in range(0, children.size() - 1):
		if children[i].type == 'rock':
			if self.type == 'paper':
				current_distance = position.distance_squared_to(children[i].position)
				if current_distance < min_distance:
					min_distance = current_distance
					min_node = children[i]
		if children[i].type == 'paper':
			if self.type == 'scissors':
				current_distance = position.distance_squared_to(children[i].position)
				if current_distance < min_distance:
					min_distance = current_distance
					min_node = children[i]
		if children[i].type == 'scissors':
			if self.type == 'rock':
				current_distance = position.distance_squared_to(children[i].position)
				if current_distance < min_distance:
					min_distance = current_distance
					min_node = children[i]
	target = min_node

func process_collision(colliding_entity: Area2D):
	if type == 'rock' && colliding_entity.type == 'paper':
		type = 'paper'
		process_type_update()
	if type == 'paper' && colliding_entity.type == 'scissors':
		type = 'scissors'
		process_type_update()
	if type == 'scissors' && colliding_entity.type == 'rock':
		type = 'rock'
		process_type_update()

func process_type_update():
	target = null
	locate_target()
	sfx.play()
	if type == 'rock':
		sprite.texture = rock_texture
	elif type == 'paper':
		sprite.texture = paper_texture
	else:
		sprite.texture = scissors_texture


func _on_area_entered(area):
	if area.is_in_group("field_units"):
		process_collision(area)
