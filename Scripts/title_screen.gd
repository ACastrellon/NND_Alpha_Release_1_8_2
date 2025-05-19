extends Control

@export var next_scene : String


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(next_scene)
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_tog_music_button_up() -> void:
	MusicController.toggle_music()
	print("button Pressed")
	pass # Replace with function body.
