extends Control

func _ready():
	$Music.set_value_no_signal(Global.save.settings.volume[0])
	$SoundEffects.set_value_no_signal(Global.save.settings.volume[1])
	$PostProcessing.set_pressed_no_signal(Global.save.settings.post_processing)
	
	if OS.get_model_name() != "GenericDevice":
		$Fullscreen.queue_free()
	else:
		$Fullscreen.set_pressed_no_signal(Global.save.settings.fullscreen)

func back():
	$"..".change_active($"../Main")
	Global.write_save(Global.save)

func set_music(value):
	Global.save.settings.volume[0] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func set_sound_effects(value):
	Global.save.settings.volume[1] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), value)

func post_process_toggle(button_pressed):
	Global.save.settings.post_processing = button_pressed
	for node in get_tree().current_scene.get_children(true):
		if node is WorldEnvironment && not button_pressed:
			node.queue_free()

func fullscreen_toggle(button_pressed):
	Global.save.settings.fullscreen = button_pressed
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
