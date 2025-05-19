extends Node

#WordColors.gd

var NounColor: String
var VerbColor: String
var AdjColor: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NounColor =  "def565"  #"f7c07c"
	VerbColor = "2c7fb8"#"f07416"
	AdjColor = "7fcdbb"#"f08e16"
	pass # Replace with function body.

func _get_word_color(word:Word)->Color:
	var x=word._get_word_type()
	match x:
		"NOUN":
			return Color.html(NounColor)
		"VERB":
			return Color.html(VerbColor)
		"ADJ":
			return Color.html(AdjColor)
		_:
			return Color.WEB_GRAY
