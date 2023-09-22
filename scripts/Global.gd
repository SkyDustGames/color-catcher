extends Node

const colors = [
	Color("#fcba03"),
	Color("#32a852"),
	Color("#4287f5"),
	Color("#eb4034")
]

func load_save():
	var default = {
		"score": 0,
		"skins": [0],
		"settings": {
			"post_processing": true,
			"volume": [0.5, 0.5],
			"fullscreen": false
		}
	}
	
	if not FileAccess.file_exists("user://game.save"):
		write_save(default)
		return default
		
	var file = FileAccess.open("user://game.save", FileAccess.READ)
	return JSON.parse_string(file.get_line())

func write_save(dict):
	var file = FileAccess.open("user://game.save", FileAccess.WRITE)
	file.store_line(JSON.stringify(dict))
	
@onready var save: Dictionary = load_save()

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or NOTIFICATION_WM_GO_BACK_REQUEST:
		write_save(save)
