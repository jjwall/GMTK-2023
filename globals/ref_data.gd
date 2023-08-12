extends Node

func load_mission_level_data(mission_id: String):
	var json_file = "res://assets/data/mission_levels/%s.json" %[str(mission_id)]
	return Utils.load_json(json_file)
	
var mission_level_data := {
	"01" = {
		"target_winning_unit": "paper",
		"max_ink_meter_amount": 1000,
		"next_mission": "02",
		"ink_timer": 4,
		"background": "res://backgrounds/forest/forest.tscn",
		"level": load_mission_level_data("01") # great starter level
	},
	"02" = {
		"target_winning_unit": "scissors",
		"next_mission": "03",
		"background": "res://backgrounds/starry_night/starry_night.tscn",
		"level": load_mission_level_data("02") # meh it's fine
	},
	"03" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("03"), # not enough units
		"next_mission": "04"
	},
	"04" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("04"), # rock seems like the right challenge
		"next_mission": "05"
	},
	"05" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("05"), # this is a good difficulty / well designed
		"next_mission": "06"
	},
	"06" = {
		"target_winning_unit": "scissors", # hard level
		"level": load_mission_level_data("06"),
		"next_mission": "07"
	},
	"07" = {
		"target_winning_unit": "scissors", # unique, not sure if scissors is right
		"level": load_mission_level_data("07"),
		"next_mission": "08"
	},
	"08" = {
		"target_winning_unit": "rock",
		"level": load_mission_level_data("08")
	},
	"09" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"10" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"11" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"12" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"13" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"14" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"15" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"16" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"17" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"18" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"19" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"20" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"21" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"22" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"23" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"24" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"25" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"26" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"27" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"28" = {
		"target_winning_unit": "paper",
		"level": [],
		"next_mission": null,
	},
}
