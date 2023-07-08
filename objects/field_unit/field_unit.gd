extends CharacterBody2D

const SPEED = 300.0
var random_x_pos = randf_range(-200, 200)
var random_y_pos = randf_range(-200, 200)

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, random_x_pos, SPEED)
	velocity.y = move_toward(velocity.y, random_y_pos, SPEED)

	move_and_slide()
