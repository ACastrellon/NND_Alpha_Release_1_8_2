extends Node

var music_file = load("res://Sounds/Music/Train Theme.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_music()
	pass # Replace with function body.

func play_music()-> void:
	$Music.stream = music_file
	$Music.play()
	
func toggle_music()->void:
	if $Music.is_playing():
		$Music.stop()
	else:
		$Music.play()
