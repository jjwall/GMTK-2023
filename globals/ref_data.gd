extends Node

func load_mission_level_data(mission_id: String):
	var json_file = "res://assets/data/mission_levels/%s.json" %[str(mission_id)]
	return Utils.load_json(json_file)
	
var mission_level_data := {
	"01" = {
		"target_winning_unit": "paper",
		"max_ink_meter_amount": 1000,
		"ink_timer": 4,
		"level": load_mission_level_data("01"), # great starter level
		"background": "res://backgrounds/forest/forest.tscn",
	},
	"02" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("02"), # meh it's fine
		"background": "res://backgrounds/forest/forest.tscn",
	},
	"03" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("03"), # not enough units
		"background": "res://backgrounds/forest/forest.tscn",
	},
	"04" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("04"), # rock seems like the right challenge
		"background": "res://backgrounds/forest/forest.tscn",
	},
	"05" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("05"), # this is a good difficulty / well designed
		"background": "res://backgrounds/desert/desert.tscn"
	},
	"06" = {
		"target_winning_unit": "scissors", # hard level
		"level": load_mission_level_data("06"),
#		"background": "res://backgrounds/desert/desert.tscn"
		"background": "res://backgrounds/castle/castle.tscn"
	},
	"07" = {
		"target_winning_unit": "scissors", # unique, not sure if scissors is right
		"level": load_mission_level_data("07"),
#		"background": "res://backgrounds/desert/desert.tscn",
		"background": "res://backgrounds/tech/tech.tscn",
	},
	"08" = {
		"target_winning_unit": "rock", # hard level should be at end of missions
		"level": load_mission_level_data("08"),
#		"background": "res://backgrounds/desert/desert.tscn",
		"background": "res://backgrounds/mountains/mountains.tscn"
	},
	"09" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("09"),
		"background": "res://backgrounds/underwater/underwater.tscn",
	},
	"10" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("10"), # very random, based on wave function collapse
		"background": "res://backgrounds/underwater/underwater.tscn",
	},
	"11" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("11"),
		"background": "res://backgrounds/underwater/underwater.tscn",
		#"next_mission": "11"
	},
	"12" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("12"),
	},
	"13" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("13"),
	},
	"14" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("14"),
	},
	"15" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("15"),
	},
	"16" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("16"),
	},
	"17" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("17"),
	},
	"18" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("18"),
	},
	"19" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("19"),
	},
	"20" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("20"),
	},
	#"21" = {
		#"target_winning_unit": "paper",
		#"level": load_mission_level_data("21"),
	#},
	#"22" = {
		#"target_winning_unit": "scissors",
		#"level": load_mission_level_data("22"),
	#},
	#"23" = {
		#"target_winning_unit": "rock",
		#"level": load_mission_level_data("23"),
	#},
	#"24" = {
		#"target_winning_unit": "rock",
		#"level": load_mission_level_data("24"),
	#},
	#"25" = {
		#"target_winning_unit": "rock",
		#"level": load_mission_level_data("25"),
	#},
	#"26" = {
		#"target_winning_unit": "paper",
		#"level": load_mission_level_data("26"),
	#},
	#"27" = {
		#"target_winning_unit": "paper",
		#"level": load_mission_level_data("27"),
	#},
	#"28" = {
		#"target_winning_unit": "rock",
		#"level": load_mission_level_data("28"),
		#"next_mission": null,
	#},
}

var pageScore = 0
