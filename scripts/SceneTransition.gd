extends CanvasLayer

func change_scene(target):
	var animation = $AnimationPlayer
	animation.play("dissolve")
	
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("dissolve")
