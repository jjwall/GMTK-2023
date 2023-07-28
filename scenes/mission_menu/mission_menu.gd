extends Control

var gameplay_scene = "res://scenes/gameplay/gameplay.tscn"
var main_menu_scene = "res://scenes/main_menu/main_menu.tscn"
var ui_theme = preload("res://assets/themes/ui_theme.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	create_mission_buttons()
	$mission_01.visible = false

func create_mission_buttons():
	var button_pos_y = -150
	var button_pos_x = 100
	var button_height = 200
	var button_length = 200
	for r in range(7):
		button_pos_y += 250
		button_pos_x = 100
		print(r)
		for c in range(4):
			var new_mission_button = Button.new()
			new_mission_button.set_position(Vector2(button_pos_x, button_pos_y))
			new_mission_button.set_size(Vector2(button_length, button_height))
			new_mission_button.theme = ui_theme
			self.add_child(new_mission_button)
			button_pos_x += 250
			print(c)
		
#		function buildGrid (map) {
#		var grid =$("#grid");
#		grid.empty();
#		for (var r = 0; r < map.length; r++) {
#			for (var c = 0; c < map[0].length; c++) {
#				if (map[r][c]) {
#					//$(`#grid .grid-square[data-r=${r}][data-c=${c}]`).append(`<img src=${map[r][c]}>`);
#					grid.append(`<div class="grid-square" data-r = "${r}" data-c = "${c}" data-action=${map[r][c].action}><div class="grid-style" data-r = "${r}" data-c = "${c}"></div><img src=${map[r][c].img}></div>`);
#				} else {
#					grid.append(`<div class="grid-square" data-r = "${r}" data-c = "${c}" data-action="0"><div class="grid-style" data-r = "${r}" data-c = "${c}"></div></div>`);
#				}
#			}
#			grid.append("<br>");

func change_to_scene(scene: String):
	get_tree().change_scene_to_file(scene)

func _on_mission_01_pressed():
	change_to_scene(gameplay_scene)

func _on_back_button_pressed():
	change_to_scene(main_menu_scene)
