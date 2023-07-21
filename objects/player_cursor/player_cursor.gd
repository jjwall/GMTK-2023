extends RigidBody2D

# Store the points of the line
var line_points = PackedVector2Array()
# Reference to the CollisionPolygon2D node
var collision_polygon

var collision_children: Array[CollisionShape2D] = []

# Reference to the Line2D node
var line_node

func _ready():
	# Get the reference to the Line2D and CollisionPolygon2D nodes
	line_node = get_node("Line2D")
	collision_polygon = get_node("CollisionShape2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		# Check if the left mouse button is pressed
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# Add the current mouse position to the line_points array
			line_points.append(event.position)
			line_node.points = line_points
			collision_polygon = CollisionShape2D.new()
			collision_polygon.shape = CircleShape2D.new()
			collision_polygon.position = event.position
			self.add_child(collision_polygon)
			collision_children.append(collision_polygon)
			# Update the Line2D node with the new points
			# Update the CollisionPolygon2D node with the new points
#			collision_polygon.polygon = line_points
#			var shape = ConvexPolygonShape2D.new()
#			shape.set_points(line_points)
#			collision_polygon.shape = shape
		
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Reset the line_points array when the left mouse button is pressed
		line_points.clear()
		line_node.points = line_points
		delete_children(collision_children)
#		collision_polygon.polygon = line_points

func delete_children(node: Array[CollisionShape2D]):
	for n in range(node.size()):
		node[n].queue_free()
#		node.remove_at(n)
	collision_children = []


#func _input(event):
#	# Mouse in viewport coordinates.
#	if event is InputEventMouseButton:
#		print("Mouse Click/Unclick at: ", event.position)
#	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)
	# Print the size of the viewport.
#	print("Viewport Resolution is: ", get_viewport_rect().size)

func _on_body_entered(body):
	if body.is_in_group("field_units"):
		print("yo")
		# Calculate the point of intersection
#		var intersection = get_collision_point()
#
#		# Calculate the normal of the collision (perpendicular to the line)
#		var normal = get_collision_normal()
#
#		# Calculate the direction from the intersection point to the object's position
#		var to_intersection = intersection - global_position
#
#		# Project the direction onto the normal to get the component that should be removed
#		var projection = to_intersection.project(normal)
#
#		# Calculate the new position of the object to prevent it from crossing the line
#		global_position += projection
#		velocity = Vector2.ZERO # Stop the object's movement
