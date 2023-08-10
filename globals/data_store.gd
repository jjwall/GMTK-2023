extends Node

const filename = "user://rps_save.json"

var current: Dictionary

var _default_values := {
	survival_highscore = 0,
	total_stars = 0,
	ad_free_purchased = false,
	sfx_volume = 0,
	music_volume = 0,
	missions = {
		"01" = {
			"locked": false,
			"stars": 0,
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
		"05" = {
			"locked": true,
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
}

func _ready():
	reload()

func save():
	var data = JSON.stringify(current)
	var file = FileAccess.open(filename, FileAccess.WRITE)
	file.store_string(data)
	file.close()
	print("Game saved")

func reload():
	var file = FileAccess.open(filename, FileAccess.READ)
	if not file:
		current = _default_values.duplicate(true)
		print("No save game found")
		return
	var data = file.get_as_text()
	current = JSON.parse_string(data)
	
	print("Loaded save game: ", current)

# Test data:
#missions = {
#		"01" = {
#			"locked": false,
#			"stars": 3,
#		},
#		"02" = {
#			"locked": false,
#			"stars": 1,
#		},
#		"03" = {
#			"locked": false,
#			"stars": 2,
#		},
#		"04" = {
#			"locked": false,
#			"stars": 1,
#		},
#		"05" = {
#			"locked": false,
#			"stars": 0,
#		},
#		"06" = {
#			"locked": false,
#			"stars": 0,
#		},
#		"07" = {
#			"locked": false,
#			"stars": 0,
#		},
#		"08" = {
#			"locked": false,
#			"stars": 0,
#		},
#		"09" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"10" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"11" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"12" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"13" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"14" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"15" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"16" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"17" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"18" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"19" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"20" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"21" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"22" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"23" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"24" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"25" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"26" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"27" = {
#			"locked": true,
#			"stars": 0,
#		},
#		"28" = {
#			"locked": true,
#			"stars": 0,
#		},
#	}
