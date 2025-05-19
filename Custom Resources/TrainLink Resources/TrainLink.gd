extends Resource

class_name TrainLink

#TrainLink.gd

var trainLinkColor: String # String with Key for TainLinkColor
var acceptableWordType: String  # type of word the TrainLink Accepts NOUN, ADJ, VERB
var trainLinkType: String # Carriage or Engine
var trainLinkWord: Word # the word inside the TrainLink
var trainLinkBadge: String #

func _init()->void:
	trainLinkWord = Word.new()
	trainLinkColor = "WHITE"
	acceptableWordType = trainLinkWord.wordType
	trainLinkType = "TRAINLINK"
	trainLinkBadge ="#"

func _print_TrainLink()->void:
	# Prints the trainlink in the command line, in the following format;e.g
	# |BLACK GA CARRAIGE|
	# English
	print("|"+trainLinkColor+" "+ trainLinkBadge +" "+trainLinkType+"|" )
	trainLinkWord._print_english()

func _get_train_link_color()-> String:
	return trainLinkColor

func _get_acceptable_word_type()-> String:
	return acceptableWordType

func _get_train_link_type()->String:
	return trainLinkType # Carriage or Engine

func _get_train_link_word()-> Word:
	return trainLinkWord # Returns the Word

func _get_train_link_badge()->String:
	return trainLinkBadge

func _get_english()->String:
	var eng =trainLinkWord._get_english() +trainLinkBadge
	return eng

func _set_train_link_color()->void:
	pass

func _update_train_link_word(inputWord:Word)->void:
	trainLinkWord =inputWord

func _is_empty()->bool:
	return trainLinkWord._is_empty()

func _is_valid_train_link()->bool:
	if not(trainLinkWord._is_empty()) and trainLinkBadge != "#":
		return true
	else:
		return false

func _update_train_link_color(inputColor:String)->void:
	trainLinkColor = inputColor
	pass
