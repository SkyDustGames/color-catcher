extends Node

const colors = [
	Color("#ff0000"),
	Color("#ffffff"),
	Color("#00ffff"),
	Color("#00ff00"),
	Color("#ff00ff")
]

func load_save():
	var default = {
		"score": 0,
		"skins": ["0"],
		"settings": {
			"post_processing": true,
			"volume": [5.0, 0.0],
			"fullscreen": false
		},
		"skin": "Circle",
		"coins": 0
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
var skin: Texture2D

func _ready():
	skin = Skins.skins[save.skin].sprite
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), save.settings.volume[0])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), save.settings.volume[1])
	if save.settings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
