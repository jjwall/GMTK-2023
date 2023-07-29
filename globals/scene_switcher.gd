extends Node

var current_scene = null

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
	current_scene.free()
	current_scene = scene
#	current_scene = tree.get_child(tree.get_child_count() - 1)
#	tree.current_scene.free()
#	tree.current_scene = scene
	var root := tree.get_root() as Window
	root.add_child(scene)
	tree.set_current_scene(current_scene)
	print(tree.current_scene)

#func _change_scene(scene: Node):
#	get_tree().current_scene.free()
#	get_tree().get_root().add_child(scene)
#	get_tree().get_root().set_current_scene(scene)

func change_to_scene_file(scene_file: String):
	get_tree().change_scene_to_file(scene_file)

# Called when the node enters the scene tree for the first time.
func _ready():
	var tree = get_tree().get_root()
	current_scene = tree.get_child(tree.get_child_count() - 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
