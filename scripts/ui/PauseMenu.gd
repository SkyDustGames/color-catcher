extends ColorRect

var paused = false
@onready var environment = get_tree().current_scene.get_node("./Environment")

func _on_pause_button_pressed():
	paused = not paused
	get_tree().paused = paused
	if paused:
		show()
	else:
		hide()
	Global.write_save(Global.save)

func _on_restart_pressed():
	_on_pause_button_pressed()
	SceneTransition.change_scene("res://scenes/game.tscn")

func _on_menu_pressed():
	_on_pause_button_pressed()
	SceneTransition.change_scene("res://scenes/menu.tscn")

func _on_quit_pressed():
	_on_pause_button_pressed()
	get_tree().quit()
