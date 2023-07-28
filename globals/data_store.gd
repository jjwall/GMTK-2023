extends Node

# Mocking save game functionality for now.
var missions := { # what does := vs = do ?
	"01" = {
		"locked": false,
		"stars": 0,
		"level": [
			["_", "_", "r"],
			["_", "p", "_"], # working idea...
			["s", "_", "_"],
		]
	},
	"02" = {
		"locked": true,
		"stars": 0,
	},
	"03" = {
		"locked": true,
		"stars": 0,
	},
	"04" = {
		"locked": true,
		"stars": 0,
	},
	# and so on...
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
