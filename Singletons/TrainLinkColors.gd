extends Node

#TrainLinkColors.gd

var whiteEngine
var whiteCarriage
var blackEngine
var blackCarriage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	whiteCarriage =preload("res://PNGs/Traincars/WhiteCarriage.png")
	blackCarriage =preload("res://PNGs/Traincars/BlackCarriage.png")
	whiteEngine=preload("res://PNGs/Traincars/WhiteEngine.png")
	blackEngine= preload("res://PNGs/Traincars/BlackEngine.png")
	pass # Replace with function body.

func _get_train_link_texture(tlink:TrainLink)->Texture2D:
	var trainLinkType=tlink._get_train_link_type()
	var trainLinkColor=tlink._get_train_link_color()
	match trainLinkType:
		"CARRIAGE":
			match trainLinkColor:
				"WHITE":
					return whiteCarriage
				"BLACK":
					return blackCarriage
				_: 
					print("This is a place holder, something went wrong")
					return whiteCarriage
		"ENGINE":
			match trainLinkColor:
				"WHITE":
					return whiteEngine
				"BLACK":
					return blackEngine
				_: return whiteEngine
		_: 
			print("This is a place holder, something went wrong")
			return whiteCarriage
					
