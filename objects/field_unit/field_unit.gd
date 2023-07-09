extends Area2D

@export var type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null
@export var trigger_distance = 500

var SPEED = 75
var target : Area2D = null
var aimless_direction = null

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = randf_range(75, 125)
	sprite = $Sprite2D
	process_type_update()
	aimless_direction = Vector2(randf(), randf())

func _physics_process(delta):	
	if !target:
		locate_target()
	
	var direction = global_position.direction_to(target.position)
	
	if (position - target.position).length() < trigger_distance:
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
	var children = field_units_group.get_children()
	children.shuffle()
	for i in range(0, field_units_group.get_child_count() - 1):
		if children[i].type == 'rock':
			if self.type == 'paper':
				target = children[i]
		if children[i].type == 'paper':
			if self.type == 'scissors':
				target = children[i]
		if children[i].type == 'scissors':
			if self.type == 'rock':
				target = children[i]

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
	locate_target()
	if type == 'rock':
		sprite.texture = rock_texture
	elif type == 'paper':
		sprite.texture = paper_texture
	else:
		sprite.texture = scissors_texture


func _on_area_entered(area):
	if area.is_in_group("field_units"):
		process_collision(area)
