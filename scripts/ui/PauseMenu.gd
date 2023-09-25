extends Control

var paused = false
@onready var environment = get_tree().current_scene.get_node("./Environment")
@onready var menu = $PauseMenu

func _input(event):
	if event.is_action_pressed("pause"):
		_on_pause_button_pressed()

func _on_pause_button_pressed():
	paused = not paused
	get_tree().paused = paused
	if paused:
		menu.show()
	else:
		menu.hide()
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
