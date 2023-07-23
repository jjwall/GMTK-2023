extends RigidBody2D

# Notes:
# Player_Cursor could be a regular node
# That dynamically appends a static or rigidbody2d
# when the line in being drawn

var line_points = PackedVector2Array()
var collision_children: Array[CollisionShape2D] = []
var line_node: Line2D

func _ready():
	# Get the reference to the Line2D and CollisionPolygon2D nodes
	line_node = get_node("Line2D")

func _input(event):
	if event is InputEventMouseMotion:
		# Check if the left mouse button is pressed
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
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
		
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Reset the line_points array when the left mouse button is pressed
		line_points.clear()
		line_node.points = line_points
		delete_collision_children()

func delete_collision_children():
	for n in range(collision_children.size()):
		collision_children[n].queue_free()
		
	collision_children = []

