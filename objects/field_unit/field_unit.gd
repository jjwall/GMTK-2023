extends CharacterBody2D

@export var type = 'rock' # | 'paper' | 'scissors'

const SPEED = 300.0
var random_x_pos = randf_range(-200, 200)
var random_y_pos = randf_range(-200, 200)

const paper = preload("res://assets/textures/paper_emoji.png")
const rock = preload("res://assets/textures/rock_emoji.png")
const scissors = preload("res://assets/textures/scissors_emoji.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if type == 'rock':
		$Sprite2D.texture = rock
	elif type == 'paper':
		$Sprite2D.texture = paper
	else:
		$Sprite2D.texture = scissors


func _physics_process(delta):
	velocity.x = move_toward(velocity.x, random_x_pos, SPEED)
	velocity.y = move_toward(velocity.y, random_y_pos, SPEED)

	move_and_slide()
