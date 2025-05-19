extends TrainLink

class_name Carriage

#Carraige.gd

# Variables Inherited from TrainLink Class
#  trainLinkColor: String # String with Key TrainLinkColor
#  acceptableWordType: String  # type of word the TrainLink Accepts NOUN, ADJ, VERB
#  trainLinkType: String # Carriage or Engine
#  trainLinkWord: word # the word inside the TrainLink
#  trainLinkBadge: String # GA, WO, NI, DE, HE
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


func _init(inputNoun:Noun)->void:

	trainLinkType = "CARRIAGE"
	trainLinkWord = inputNoun
	acceptableWordType = "NOUN"
	

func _get_english()->String:
	var eng= " "+trainLinkWord._get_english() +" "+trainLinkBadge+" "
	return eng
	
func _set_badge(badge:String)->void:
	trainLinkBadge = badge

func _set_train_link_color()->void:
	if trainLinkBadge == "\u304c":
		trainLinkColor= "BLACK"
	else:
		trainLinkColor="WHITE"

#func _update_train_link_color()->void:
#	pass
