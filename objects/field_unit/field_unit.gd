extends RigidBody2D

signal field_unit_type_update()

@export var unit_type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null

@export var imprecision = 4 #increase this number for more performance
var check_num = 0
var paused = true

var SPEED = 50
var speed_min = 65
var speed_max = 115
var target : RigidBody2D = null
var aimless_direction: Vector2 = Vector2((randf() * 2) - 1, (randf() * 2) - 1)

const paper_texture = preload("res://assets/textures/paper_emoji.png")
const rock_texture = preload("res://assets/textures/rock_emoji.png")
const scissors_texture = preload("res://assets/textures/scissors_emoji.png")

var resolution_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var resolution_height = ProjectSettings.get_setting("display/window/size/viewport_height")

var sprite : Sprite2D
var target_search : Area2D
var sfx : AudioStreamPlayer
var collisionArea : Area2D

var maxCollisionCheckDepth := 19
var currentCollisionCheckDepth := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = randf_range(speed_min, speed_max)
	sprite = $Sprite2D
	sprite.modulate.a = 0
	target_search = $TargetSearchArea
	collisionArea = $Area2D
	sfx = $pop_sfx
	init_unit(unit_type)
	var angle = randf() * PI * 2
	aimless_direction = Vector2(cos(angle), sin(angle))
	fade_unit_in()
	$unit_spawned_timer.start()

func fade_unit_in():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 1, 1)

func _physics_process(delta):
	if !paused:
		check_num += 1
		if check_num == imprecision:
			locate_target()
			check_num = 0
		
		if target:
			var direction = global_position.direction_to(target.position)
			#self.linear_velocity = direction * SPEED
	#		position += direction * SPEED * delta
			move_and_collide(direction * 100 * delta) # should discuss random speed
		else:
	#		position += aimless_direction * SPEED * delta
			move_and_collide(aimless_direction * 60 * delta)
	#		aimless_direction = Vector2((randf() * 2) - 1, (randf() * 2) - 1)
			#self.linear_velocity = aimless_direction * SPEED
		
		wrap_position()
		currentCollisionCheckDepth = 0

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
	for child in children:
		if child.is_in_group("field_units"):
			if child.unit_type == 'rock':
				if self.unit_type == 'paper':
					current_distance = position.distance_squared_to(child.position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = child
			elif child.unit_type == 'paper':
				if self.unit_type == 'scissors':
					current_distance = position.distance_squared_to(child.position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = child
			elif child.unit_type == 'scissors':
				if self.unit_type == 'rock':
					current_distance = position.distance_squared_to(child.position)
					if current_distance < min_distance:
						min_distance = current_distance
						min_node = child
	target = min_node

#func get_random_target():
	#var children = field_units_group.get_children()
##	var children: Array[Node2D] = target_search.get_overlapping_bodies()
	#if children.size() < 1:
		#return
	#
	#children.shuffle()
	#for i in range(0, children.size() - 1):
		#if !children[i].is_in_group("field_units_group"):
			#if children[i].unit_type == 'rock':
				#if self.unit_type == 'paper':
					#target = children[i]
			#if children[i].unit_type == 'paper':
				#if self.unit_type == 'scissors':
					#target = children[i]
			#if children[i].unit_type == 'scissors':
				#if self.unit_type == 'rock':
					#target = children[i]


func process_collision(colliding_entity: RigidBody2D):
	if unit_type == 'rock' && colliding_entity.unit_type == 'paper':
		process_type_update('paper')
	elif unit_type == 'paper' && colliding_entity.unit_type == 'scissors':
		process_type_update('scissors')
	elif unit_type == 'scissors' && colliding_entity.unit_type == 'rock':
		process_type_update('rock')

func init_unit(init_unit_type: String):
	unit_type = init_unit_type
	target = null
	locate_target()
	
	if unit_type == 'rock':
		sprite.texture = rock_texture
	elif unit_type == 'paper':
		sprite.texture = paper_texture
	else:
		sprite.texture = scissors_texture

func process_type_update(new_unit_type: String):
	unit_type = new_unit_type
	target = null
	locate_target()
	sfx.play()
	if unit_type == 'rock':
		GameplayVars.current_rock_count += 1
		GameplayVars.current_scissors_count -= 1
		sprite.texture = rock_texture
	elif unit_type == 'paper':
		GameplayVars.current_paper_count += 1
		GameplayVars.current_rock_count -= 1
		sprite.texture = paper_texture
	else:
		GameplayVars.current_scissors_count += 1
		GameplayVars.current_paper_count -= 1
		sprite.texture = scissors_texture
		
	field_unit_type_update.emit()
	check_overlap()

func _on_area_2d_body_entered(body):
	if body.is_in_group("field_units"):
		process_collision(body)

func _on_unit_spawned_timer_timeout():
	paused = false
	check_overlap()

func check_overlap():
	currentCollisionCheckDepth += 1
	if currentCollisionCheckDepth <= maxCollisionCheckDepth:
		var overlapping = collisionArea.get_overlapping_bodies()
		for body in overlapping:
			process_collision(body)
