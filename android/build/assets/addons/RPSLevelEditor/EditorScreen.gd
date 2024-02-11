@tool
extends CenterContainer

var selectedTile = 0 #R = 0, P = 1, S = 2

const rockImage = preload("res://assets/textures/rock_emoji_smol.png")
const paperImage = preload("res://assets/textures/paper_emoji_smol.png")
const scissorImage = preload("res://assets/textures/scissors_emoji_smol.png")
const emptyImage = preload("res://assets/textures/blank_smol.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_button_down(buttonID):
	var depressedButton = $VBoxContainer/GridContainer.find_child("Button" + str(buttonID + 1))
	if(selectedTile == 0):
		depressedButton.icon = rockImage
	elif(selectedTile == 1):
		depressedButton.icon = paperImage
	elif(selectedTile == 2):
		depressedButton.icon = scissorImage
	elif(selectedTile == 3):
		depressedButton.icon = emptyImage


func _on_rock_pressed():
	selectedTile = 0
	$VBoxContainer/HBoxContainer2/RockButton.disabled = true
	$VBoxContainer/HBoxContainer2/PaperButton.disabled = false
	$VBoxContainer/HBoxContainer2/ScissorButton.disabled = false
	$VBoxContainer/HBoxContainer2/EmptyButton.disabled = false


func _on_paper_pressed():
	selectedTile = 1
	$VBoxContainer/HBoxContainer2/RockButton.disabled = false
	$VBoxContainer/HBoxContainer2/PaperButton.disabled = true
	$VBoxContainer/HBoxContainer2/ScissorButton.disabled = false
	$VBoxContainer/HBoxContainer2/EmptyButton.disabled = false


func _on_scissor_pressed():
	selectedTile = 2
	$VBoxContainer/HBoxContainer2/RockButton.disabled = false
	$VBoxContainer/HBoxContainer2/PaperButton.disabled = false
	$VBoxContainer/HBoxContainer2/ScissorButton.disabled = true
	$VBoxContainer/HBoxContainer2/EmptyButton.disabled = false


func _on_empty_button_pressed():
	selectedTile = 3
	$VBoxContainer/HBoxContainer2/RockButton.disabled = false
	$VBoxContainer/HBoxContainer2/PaperButton.disabled = false
	$VBoxContainer/HBoxContainer2/ScissorButton.disabled = false
	$VBoxContainer/HBoxContainer2/EmptyButton.disabled = true


func _on_import_button_pressed():
	var file = FileAccess.open(
		"res://assets/data/mission_levels/" + $VBoxContainer/HBoxContainer/LineEdit.text + ".json",
		 FileAccess.READ)
	var data = file.get_as_text()
	var buttonGrid = JSON.parse_string(data)
	var buttons = $VBoxContainer/GridContainer.find_children("Button*")
	
	for i in 20:
		for j in 10:
			match buttonGrid[i][j]:
				"r":
					buttons[(i*10)+j].icon = rockImage
				"p":
					buttons[(i*10)+j].icon = paperImage
				"s":
					buttons[(i*10)+j].icon = scissorImage
				_:
					buttons[(i*10)+j].icon = emptyImage


func _on_export_button_pressed():
	var buttons = $VBoxContainer/GridContainer.find_children("Button*")
	var buttonGrid = []
	for i in 20: # Hard coded since the # of buttons is essentially hardcoded
		buttonGrid.append([])
		for j in 10:
			match buttons[(i*10)+j].icon:
				rockImage:
					buttonGrid[i].append("r")
				paperImage:
					buttonGrid[i].append("p")
				scissorImage:
					buttonGrid[i].append("s")
				emptyImage:
					buttonGrid[i].append("_")
	print(buttonGrid)
	var data = JSON.stringify(buttonGrid)
	var file = FileAccess.open(
		"res://assets/data/mission_levels/" + $VBoxContainer/HBoxContainer/LineEdit.text + ".json",
		 FileAccess.WRITE)
	file.store_string(data)
	file.close()


func _on_clear_button_pressed():
	var buttons = $VBoxContainer/GridContainer.find_children("Button*")
	for button in buttons:
		button.icon = emptyImage
