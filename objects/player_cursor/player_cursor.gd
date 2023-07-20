extends Node

# Store the points of the line
var line_points = PackedVector2Array()
# Reference to the CollisionPolygon2D node
var collision_polygon

# Reference to the Line2D node
var line_node

func _ready():
	# Get the reference to the Line2D and CollisionPolygon2D nodes
	line_node = get_node("Line2D")
	collision_polygon = get_node("CollisionPolygon2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		# Check if the left mouse button is pressed
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# Add the current mouse position to the line_points array
			line_points.append(event.position)
			# Update the Line2D node with the new points
			line_node.points = line_points
			# Update the CollisionPolygon2D node with the new points
			collision_polygon.polygon = line_points
		
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Reset the line_points array when the left mouse button is pressed
		line_points.clear()
		line_node.points = line_points
		collision_polygon.polygon = line_points



#func _input(event):
#	# Mouse in viewport coordinates.
#	if event is InputEventMouseButton:
#		print("Mouse Click/Unclick at: ", event.position)
#	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)
	# Print the size of the viewport.
#	print("Viewport Resolution is: ", get_viewport_rect().size)


func _on_area_entered(area):
	print("hi?")
	pass # Replace with function body.
