extends Node

#func change_to_scene(scene_filename: String) -> Node:
#	var scene = load(scene_filename).instantiate()
##	get_tree().get_root().call_deferred(_change_scene, scene)
#	print(get_tree().current_scene)
#	get_tree().current_scene.queue_free()
##	get_tree().get_root().set_current_scene = scene
##	get_tree().set_current_scene(scene)
#	get_tree().current_scene = scene
#	get_tree().get_root().call_deferred("add_child", scene)
##	get_tree().get_root().call_deferred("set_current_scene", scene)
#	return scene

func change_to_scene(scene_filename: String) -> Node:
	var scene = load(scene_filename).instantiate()
	call_deferred("_change_scene", scene)
	return scene

func _change_scene(scene: Node):
	var tree := get_tree()
	tree.current_scene.free()
	tree.current_scene = scene
	var root := tree.get_root() as Window
	root.add_child(scene)
	root.update_mouse_cursor_state()

#func _change_scene(scene: Node):
#	get_tree().current_scene.free()
#	get_tree().get_root().add_child(scene)
#	get_tree().get_root().set_current_scene(scene)

func change_to_scene_file(scene_file: String):
	get_tree().change_scene_to_file(scene_file)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
