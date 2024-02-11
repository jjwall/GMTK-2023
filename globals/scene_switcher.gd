extends Node

var current_scene = null

func change_to_scene(scene_filename: String) -> Node:
	var scene = load(scene_filename).instantiate()
	call_deferred("_change_scene", scene)
	return scene

func _change_scene(scene: Node):
	var tree := get_tree()
	var root := tree.get_root() as Window
	tree.unload_current_scene()
	current_scene = scene
	root.add_child(scene)
	tree.set_current_scene(current_scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	var tree = get_tree().get_root()
	current_scene = tree.get_child(tree.get_child_count() - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
