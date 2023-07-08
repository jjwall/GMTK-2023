extends CharacterBody2D

@export var type = 'rock' # | 'paper' | 'scissors'

const SPEED = 300.0
var random_x_pos = randf_range(-200, 200)
var random_y_pos = randf_range(-200, 200)

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	process_type_update()


func _physics_process(delta):
	velocity.x = move_toward(velocity.x, random_x_pos, SPEED)
	velocity.y = move_toward(velocity.y, random_y_pos, SPEED)

	move_and_slide()
	var last_slide_collision = get_last_slide_collision()
	
	if last_slide_collision:
		if last_slide_collision.get_collider().is_in_group("field_units"):
			if type == 'rock' && last_slide_collision.get_collider().type == 'paper':
				type = 'paper'
				process_type_update()
			if type == 'paper' && last_slide_collision.get_collider().type == 'scissors':
				type = 'scissors'
				process_type_update()
			if type == 'scissors' && last_slide_collision.get_collider().type == 'rock':
				type = 'rock'
				process_type_update()
	
func _process(delta):
	pass

func process_type_update():
	if type == 'rock':
		$Sprite2D.texture = rock_texture
	elif type == 'paper':
		$Sprite2D.texture = paper_texture
	else:
		$Sprite2D.texture = scissors_texture
