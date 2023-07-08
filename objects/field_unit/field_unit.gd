extends CharacterBody2D

@export var type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null

var SPEED = 75
var target = null

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = randf_range(75, 150)
	process_type_update()


func _physics_process(delta):	
	if !target:
		locate_target()
		
	var direction = global_position.direction_to(target.position)
	velocity = direction * SPEED

	move_and_slide()
	var last_slide_collision = get_last_slide_collision()
	
	if last_slide_collision:
		if last_slide_collision.get_collider().is_in_group("field_units"):
			process_collision(last_slide_collision.get_collider())
	
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

func process_collision(colliding_entity: CharacterBody2D):
	locate_target()
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
	if type == 'rock':
		$Sprite2D.texture = rock_texture
	elif type == 'paper':
		$Sprite2D.texture = paper_texture
	else:
		$Sprite2D.texture = scissors_texture
