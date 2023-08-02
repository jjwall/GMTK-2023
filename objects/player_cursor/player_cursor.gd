extends RigidBody2D
signal draw_ink(amount: float)
signal reset_ink_meter()

@export var init_tween_time = 2
@export var tween_time = 2

# Notes:
# Player_Cursor could be a regular node
# That dynamically appends a static or rigidbody2d
# when the line in being drawn

var line_points = PackedVector2Array()
var collision_children: Array[CollisionShape2D] = []
var line_node: Line2D
var tween: Tween
var line_is_on_screen = false

# TODO: (Done) Temporary ink lines (fade to red over time)

func _ready():
	# Get the reference to the Line2D node
	line_node = get_node("Line2D")
	$init_line_tween_timer.wait_time = init_tween_time
	set_tween()

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and GameplayVars.ink_meter_value > 0:
			# Add the current mouse position to the line_points array
			draw_ink_line(event.position)
			
			if line_points.size() > 1:
				# Add collision line segment
				var collision_line = append_line_collision()
				# Use collision line segment length to reduce ink meter by this amount
				draw_ink.emit(collision_line.a.distance_to(collision_line.b))
				# Initialize timer to start tween and destory line after a time.
				init_line_timer()
				
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Reset the line_points array when the left mouse button is pressed
		reset_line()

func draw_ink_line(line_point_position: Vector2):
	line_points.append(line_point_position)
	line_node.points = line_points

func append_line_collision() -> SegmentShape2D:
	var collision_line = SegmentShape2D.new()
	collision_line.a = line_points[line_points.size() - 2]
	collision_line.b = line_points[line_points.size() - 1]
	var shape = CollisionShape2D.new()
	shape.shape = collision_line
	self.add_child(shape)
	collision_children.append(shape)
	return collision_line

func reset_line():
	reset_ink_meter.emit()
	line_points.clear()
	line_node.points = line_points
	reset_tween()
	delete_collision_children()
	line_is_on_screen = false

func init_line_timer():
	if !line_is_on_screen:
		line_is_on_screen = true
#		set_tween() # not necessary
		$init_line_tween_timer.start()

func set_tween():
	tween = create_tween()
	tween.tween_property(line_node, "modulate", Color.RED, tween_time)
	tween.tween_property(line_node, "modulate:a", 0, 0.5) # tween_time/4)
#	tween.tween_property(line_node, "modulate", Color(196/255.0, 30/255.0, 58/255.0, 0), tween_time)
	tween.tween_callback(on_line_expires) #.set_delay(1) -> this extends delay
	tween.pause()

func on_line_expires():
	if line_is_on_screen:
		reset_line()

func reset_tween():
	line_node.modulate = Color(1, 1, 1, 1)
	tween.stop()
#	tween.kill() # kill or stop?
	set_tween()

func delete_collision_children():
	for n in range(collision_children.size()):
		collision_children[n].queue_free()
		
	collision_children = []

func _on_init_line_tween_timer_timeout():
	if line_is_on_screen:
		tween.play()

