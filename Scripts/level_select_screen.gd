extends Control

@export var title_scene : String
@export var levelDescription: RichTextLabel
@export var current_selection_label: Label

var current_selection: String
var tutorial_scene = "res://Scenes/Tutorial_Level.tscn"
var sandbox_scene = "res://Scenes/main.tscn"

var format_description = "[left]Level Description:\n"
var tutorial_description = "\n-Learn about the Word Bank\n-Adding Train Cars\n-Cycling Badges\n-Adding Word to Train Cars\n-Adding Train Cars[/left]"

func _ready() -> void:
	current_selection="None"

func _on_exit_to_title_screen_pressed() -> void:
	get_tree().change_scene_to_file(title_scene)
	pass # Replace with function body.


func _on_go_to_level_pressed() -> void:
	match current_selection:
		"0":
			get_tree().change_scene_to_file(tutorial_scene)
		"9":
			get_tree().change_scene_to_file(sandbox_scene)
		_:
			print("No level Selected")
	
	pass # Replace with function body.

func _set_current_level_selection(inputString:String)->void:
	current_selection =inputString

func _on_tutorial_button_pressed() -> void:
	_set_current_level_selection("0")
	levelDescription.set_text(format_description+"Learn the basics of the game!"+tutorial_description)
	current_selection_label.set_text("Current Selection: Tutorial")
	pass # Replace with function body.

func _on_sandbox_button_pressed() -> void:
	_set_current_level_selection("9")
	levelDescription.set_text(format_description+"Play in the sandbox!")
	current_selection_label.set_text("Current Selection: Sandbox")
	pass # Replace with function body.
