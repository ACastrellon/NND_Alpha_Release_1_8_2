extends TrainLink

class_name Engine_

#Engine.gd

# Variables Inherited from TrainLink Class
# trainLinkColor: String # string with key for TrainLinkColor
# acceptableWordType: String  # type of word the TrainLink Accepts NOUN, ADJ, VERB
# trainLinkType: String # Carriage or Engine
# trainLinkWord: word # the word inside the TrainLink
# trainLinkBadge: String # COPULA, ADJ, VERB
# See TrainLink Class for additional information

# Functions inherited from TrainLink Class
# _print_TrainLink()->void:
# _get_train_link_color()-> String:
# _get_acceptable_word_type()-> String:
# _get_train_link_type()->String:
# _get_train_link_word()-> word:
# _get_train_link_badge()->String:
# _set_train_link_color(color:String)->void:
# See TrainLink Class for additional information


func _init(inputWord: Word)->void:
	
	trainLinkType ="ENGINE"
	trainLinkWord = inputWord

func _get_english()->String:
	var eng: String
	if trainLinkBadge == "\u3060":
		eng= " "+trainLinkWord._get_english() + " " +trainLinkBadge+" "
	else:
		eng =  " "+trainLinkWord._get_english() + " "
	return eng

func _set_engine_type()->void:
	match trainLinkBadge:
		"\u3060":
				#trainLinkBadge = "DA"
				acceptableWordType ="NOUN"
				#trainLinkColor ="BLACK"
		"\u3046":
				#trainLinkBadge = "VERB"
				acceptableWordType ="VERB"
				#trainLinkColor="WHITE"
		"\u3044":
				#trainLinkBadge = "ADJ"
				acceptableWordType ="ADJ"
				#trainLinkColor ="WHITE"
		"#":
				#trainLinkBadge = "#"
				acceptableWordType ="NA"
				trainLinkColor ="WHITE"
		
func _set_badge(badge:String)->void:
	trainLinkBadge = badge
	_set_engine_type()
	pass

func _set_train_link_color()->void:
	#if trainLinkBadge == "\u3060":
		#trainLinkColor= "BLACK"
	#else:
	trainLinkColor="WHITE"

#func _update_train_link_color()->void:
#	pass
