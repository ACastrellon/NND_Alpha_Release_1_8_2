extends Node

#StampColors.gd

var beigeStamp
var blueStamp
var goldStamp
var greenStamp
var orangeStamp
var purpleStamp
var redStamp
var roseStamp
var yellowStamp
var whiteStamp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beigeStamp =preload("res://PNGs/Stamps/BeigeStamp.png")
	blueStamp =preload("res://PNGs/Stamps/BlueStamp.png")
	goldStamp= preload("res://PNGs/Stamps/GoldStamp.png")
	greenStamp= preload("res://PNGs/Stamps/GreenStamp.png")
	orangeStamp = preload("res://PNGs/Stamps/OrangeStamp.png")
	purpleStamp = preload("res://PNGs/Stamps/PurpleStamp.png")
	redStamp= preload("res://PNGs/Stamps/RedStamp.png")
	roseStamp= preload("res://PNGs/Stamps/RoseStamp.png")
	yellowStamp= preload("res://PNGs/Stamps/YellowStamp.png")
	whiteStamp = preload("res://PNGs/Stamps/WhiteStamp.png")
	pass # Replace with function body.

func _get_prop_stamp_texture(stampID:String)->Texture2D:
	match stampID:
		"godan":
			return purpleStamp
		"ichidan":
			return blueStamp
		"helper":
			return beigeStamp
		"na-adj":
			return goldStamp
		_: 
			print("no stamp for you")
			return whiteStamp
					
					
func _get_status_stamp_texture(inputWord:Word)->Texture2D:
	var inputWordType =inputWord._get_word_type()
	
	match inputWordType:
		"VERB":
			var verbType = inputWord._get_verb_type()
			match verbType:
				"ichidan":
					match inputWord._get_formID():
						0:
							return purpleStamp
						1:
							return whiteStamp
						2:
							return roseStamp
						_:
							print("no stamp for you")
							return blueStamp
				"godan":
					match inputWord._get_formID():
						0:
							return redStamp
						1:
							return blueStamp
						2:
							return purpleStamp
						3:
							return greenStamp
						4:
							return yellowStamp
						5:
							return roseStamp
						_: 
							print("no stamp for you")
							return greenStamp
				_: 
					print("no stamp for you")
					return greenStamp
		"ADJ":
			match inputWord._get_formID():
				0:
					return purpleStamp
				1:
					return redStamp
				2:
					return roseStamp
				3:
					return whiteStamp
				_:
					print("no stamp for you")
					return greenStamp 
		_: 
			print("no stamp for you")
			return greenStamp

func _get_time_tense_stamp_texture(inputString:String)->Texture2D:
	match inputString:
		"non-past":
				return greenStamp
		"past":
			return redStamp
		_:
			return whiteStamp
			

func _get_polarity_stamp_texture(inputString:String)->Texture2D:
	match inputString:
		"positive":
				return greenStamp
		"negative":
			return redStamp
		_:
			return whiteStamp

func _get_comp_stamp_texture(inputString:String)-> Texture2D:
	match inputString:
		"white-plus":
			return whiteStamp
		"red-a":
			return redStamp
		"red-ku":
			return redStamp
		"purple-i":
			return purpleStamp
		"rose-te":
			return roseStamp
		_:
			return greenStamp
