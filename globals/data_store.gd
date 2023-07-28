extends Node

# Mocking save game functionality for now.
var missions := { # what does := vs = do ?
	"01" = {
		"locked": false,
		"stars": 3,
		"level": [
			["_", "_", "r"],
			["_", "p", "_"], # working idea... # Prob wanna store this in a static dict, not data store
			["s", "_", "_"],
		]
	},
	"02" = {
		"locked": false,
		"stars": 1,
	},
	"03" = {
		"locked": false,
		"stars": 2,
	},
	"04" = {
		"locked": false,
		"stars": 1,
	},
	"05" = {
		"locked": false,
		"stars": 0,
	},
	"06" = {
		"locked": true,
		"stars": 0,
	},
	"07" = {
		"locked": true,
		"stars": 0,
	},
	"08" = {
		"locked": true,
		"stars": 0,
	},
	"09" = {
		"locked": true,
		"stars": 0,
	},
	"10" = {
		"locked": true,
		"stars": 0,
	},
	"11" = {
		"locked": true,
		"stars": 0,
	},
	"12" = {
		"locked": true,
		"stars": 0,
	},
	"13" = {
		"locked": true,
		"stars": 0,
	},
	"14" = {
		"locked": true,
		"stars": 0,
	},
	"15" = {
		"locked": true,
		"stars": 0,
	},
	"16" = {
		"locked": true,
		"stars": 0,
	},
	"17" = {
		"locked": true,
		"stars": 0,
	},
	"18" = {
		"locked": true,
		"stars": 0,
	},
	"19" = {
		"locked": true,
		"stars": 0,
	},
	"20" = {
		"locked": true,
		"stars": 0,
	},
	"21" = {
		"locked": true,
		"stars": 0,
	},
	"22" = {
		"locked": true,
		"stars": 0,
	},
	"23" = {
		"locked": true,
		"stars": 0,
	},
	"24" = {
		"locked": true,
		"stars": 0,
	},
	"25" = {
		"locked": true,
		"stars": 0,
	},
	"26" = {
		"locked": true,
		"stars": 0,
	},
	"27" = {
		"locked": true,
		"stars": 0,
	},
	"28" = {
		"locked": true,
		"stars": 0,
	},
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
