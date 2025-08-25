extends Node

# Save location:
# C:\Users\cubbi\AppData\Roaming\Godot\app_userdata\GMTK-2023
const filename = "user://rps_save.json"

var current: Dictionary

var _default_values := {
	survival_highscore = 0,
	total_stars = 0,
	ad_free_purchased = false,
	sfx_volume = 25,
	music_volume = 25,
	mute_sound = false,
	mission_page = 0,
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
	
	print("Loaded found save game")

func delete_data():
	current = _default_values.duplicate(true)
	GameplayVars.dev_unlock = false
	save()

# For QA testing only. Should not be exposed in production.
func unlock_all_levels():
	#current.missions = _all_missions_unlocked_values.duplicate(true)
	#save()
	GameplayVars.dev_unlock = true
