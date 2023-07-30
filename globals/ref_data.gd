extends Node

func load_mission_level_data(mission_id: String):
	var json_file = "res://assets/data/mission_levels/%s.json" %[str(mission_id)]
	return FileUtils.load_json(json_file)
	
var mission_level_data := {
	"01" = {
		"target_winning_unit": "scissors",
		"max_ink_meter_amount": 1000,
		"ink_timer": 4,
		"level": load_mission_level_data("01")
	},
	"02" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("02")
	},
	"03" = {
		"target_winning_unit": "paper",
		"level": load_mission_level_data("03")
	},
	"04" = {
		"target_winning_unit": "scissors",
		"level": load_mission_level_data("04")
	},
	"05" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"06" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"07" = {
		"target_winning_unit": "paper",
		"level": []
	},
	"08" = {
		"target_winning_unit": "paper",
		"level": []
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
		"level": []
	},
}
