extends RigidBody2D
signal draw_ink(amount: float)
signal reset_ink_meter()

# Notes:
# Player_Cursor could be a regular node
# That dynamically appends a static or rigidbody2d
# when the line in being drawn

var line_points = PackedVector2Array()
var collision_children: Array[CollisionShape2D] = []
var line_node: Line2D
var tween: Tween
var line_is_on_screen = false

# TODO: Temporary ink lines (fade to red over time)

func _ready():
	# Get the reference to the Line2D and CollisionPolygon2D nodes
	line_node = get_node("Line2D")
	set_tween()

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and GameplayVars.ink_meter_value > 0:
			# Add the current mouse position to the line_points array
			line_points.append(event.position)
			line_node.points = line_points
			
			if line_points.size() > 1:
				var collision_line = SegmentShape2D.new()
				collision_line.a = line_points[line_points.size() - 2]
				collision_line.b = line_points[line_points.size() - 1]
				var shape = CollisionShape2D.new()
				shape.shape = collision_line
				self.add_child(shape)
				collision_children.append(shape)
				draw_ink.emit(collision_line.a.distance_to(collision_line.b))
				init_line()
				
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Reset the line_points array when the left mouse button is pressed
		reset_ink_meter.emit()
		line_points.clear()
		line_node.points = line_points
		reset_tween()
		delete_collision_children()
		line_is_on_screen = false

func init_line():
	if !line_is_on_screen:
		line_is_on_screen = true
#		set_tween()
		$init_line_timer.start()

func set_tween():
	tween = get_tree().create_tween()
	tween.tween_property(line_node, "modulate", Color.RED, 1)
	tween.pause()

func reset_tween():
	line_node.modulate = Color(1, 1, 1, 1)
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(line_node, "modulate", Color.RED, 1)
	tween.pause()

func delete_collision_children():
	for n in range(collision_children.size()):
		collision_children[n].queue_free()
		
	collision_children = []

func _on_timer_timeout():
	if line_is_on_screen:
		tween.play()
