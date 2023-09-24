extends AudioListener2D

@onready var musicPlayer = $MusicPlayer
@export var default: String
var song: AudioStream

func _ready():
	play_music(default)

func play_music(path):
	if not path.ends_with(".mp3"):
		path += ".mp3"
	
	var newSong = load("res://audio/" + path)
	var animation = $AnimationPlayer
	animation.play_backwards("fade")
	await animation.animation_finished
	musicPlayer.stop()
	musicPlayer.stream = newSong
	musicPlayer.play()
	animation.play("fade")
	
	song = newSong

func play(path):
	if not path.ends_with(".wav"):
		path += ".wav"
	
	var sound = load("res://audio/" + path)
	var player = AudioStreamPlayer2D.new()
	player.pitch_scale = randf_range(1.0, 1.5)
	player.bus = "Sound Effects"
	player.stream = sound
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()
