extends WorldEnvironment

func _ready():
	if not Global.save.settings.post_processing:
		queue_free()
