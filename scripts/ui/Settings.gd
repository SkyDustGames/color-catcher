extends Control

func back():
	SoundManager.play("select")
	$"..".change_active($"../Main")
