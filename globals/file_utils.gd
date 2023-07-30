extends Node

func load_json(json_file: String):
	var json = JSON.new()
	var file = FileAccess.open(json_file, FileAccess.READ)
	var error = json.parse(file.get_as_text())
	
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
#			print(data_received) # Prints array
			return data_received
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file, " at line ", json.get_error_line())
