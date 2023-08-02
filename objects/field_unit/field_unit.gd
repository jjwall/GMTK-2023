extends RigidBody2D
# 07/22 Get To-Do List:
# TODO: Main Menu (Story / Survival / How-To-Play)
# -> Story levels UI level 1-30 panels (locked 2-30) 1-3 star rank system UI
# TODO: (Done) Draw Meter UI
# -> Progress bar that that allows you to draw a certain length of line
# before preventing you from drawing anymore
# TODO: (Done) Timer on ink/
# -> As soon as you start drawing, line has a time limit. Indicated by
# transitioning from white to red coloring and fading before disappearing
# TODO: Levels
# -> 30 "Story" levels and a survival mode (infinite levels)
# -> Will be based on a seed system to develop levels, seeds won't change
# for Story levels, but will be random for infinite survival mode
# TODO: Local db store for saving player level data
# TODO: Polish -> win with winning emoji popping up and stars fluttering around
# -> loss shows winning emoji with angry squigly above (charley brown thing)
# -> SFX for drawing line, scissors snip, rock crush, paper cover
# TODO: 3D infinite backgrounds (think Maiden & Spell)
# -> If not this at least an improved version of what we have
# TODO: Anthropomorphic RPS anime chars b/c why not?

# 07/27 Get To-Do List:
# TODO: ASCII Level builder (for missions)
# TODO: Pause functionality / menu for gameplay
# -> options, restart, main menu
# TODO: Game over screen options
# -> Restart, Back (main menu or missions screen depending on game mode)
# TODO: (Done) Dynamic mission buttons, lock and star icons
# -> mock local store for tracking "locked" levels and star progress
# TODO: Star count in top right corner of mission menu
# TODO: "Ink Meter" label above progress bar
# TODO: Survival vs missions gameplay modes
# -> Pass params to gameplay scene (level ascii & game mode)

# Ideas:
# Player char unit
# Cool down on lines
# Tutorial level? -> Level 1?
signal field_unit_type_update()

@export var unit_type = 'rock' # | 'paper' | 'scissors'
@export var field_units_group: Node2D = null

@export var imprecision = 4 #increase this number for more performance
var check_num = 0

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

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = randf_range(speed_min, speed_max)
	sprite = $Sprite2D
	sprite.modulate.a = 0
	target_search = $TargetSearchArea
	sfx = $AudioStreamPlayer
	init_unit(unit_type)
	aimless_direction = Vector2((randf() * 2) - 1, (randf() * 2) - 1)
	fade_unit_in()

func fade_unit_in():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 1, 1)

func _physics_process(delta):
	check_num += 1
	if check_num == imprecision:
		locate_target()
		check_num = 0
	
	if target:
		var direction = global_position.direction_to(target.position)
		self.linear_velocity = direction * SPEED
#		position += direction * SPEED * delta
		move_and_collide(direction * SPEED * delta)
	else:
#		position += aimless_direction * SPEED * delta
#		move_and_collide(aimless_direction * SPEED * delta)
#		aimless_direction = Vector2((randf() * 2) - 1, (randf() * 2) - 1)
		self.linear_velocity = aimless_direction * SPEED
	
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
		if children[i].is_in_group("field_units"):
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

func get_random_target():
	var children = field_units_group.get_children()
#	var children: Array[Node2D] = target_search.get_overlapping_bodies()
	if children.size() < 1:
		return
	
	children.shuffle()
	for i in range(0, children.size() - 1):
		if !children[i].is_in_group("field_units_group"):
			if children[i].unit_type == 'rock':
				if self.unit_type == 'paper':
					target = children[i]
			if children[i].unit_type == 'paper':
				if self.unit_type == 'scissors':
					target = children[i]
			if children[i].unit_type == 'scissors':
				if self.unit_type == 'rock':
					target = children[i]


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

func _on_area_2d_body_entered(body):
	if body.is_in_group("field_units"):
		process_collision(body)
