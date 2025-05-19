extends Word
class_name Noun

#noun.gd

# Variables Inherited from Word Class
# wordType: String
# english: String
# reading: String
#See Word Class for additional information

# Noun specific variables
#---------------------------------

# Functions inherited from Word Class
# _get_word_type()-> String: 
# _get_english()->String:
# _get_reading()->String:
# _set_word_type()-> void:
# _print_word()->void:
# _print_english()->void
# _print_reading()->void:

# See Word Class for additional information

var root
var ending
var formMax
# Functions overridden by Noun Class
func _init()->void:
	wordType ="NOUN"
	_is_na_adj()
	#english =nounText

# Will define other properties of Nouns in later on

func _set_root(inputString:String)->void:
	root=inputString

func _set_ending(inputString:String)->void:
	ending=inputString

func _set_form_ID(inputInt:int)->void:
	formID =inputInt

func _update_reading():
	reading= root+ending

func _cycle_word_time_tense()->void:
	if _get_word_time_tense()=="non-past":
		_set_word_time_tense("past")
		_set_ending(ending.substr(0,ending.length()-1)+"だった")
		
	elif _get_word_time_tense()=="past":
		_set_word_time_tense("non-past")
		_set_ending(ending.substr(0,ending.length()-3)+"")
		
	_update_reading()
	
func _cycle_noun(direction:String)->void:
	_update_ending(direction)
	#_update_status_stamps(direction)

func _is_na_adj()->void:
	if propStamps.find("na-adj"):
		formMax=2
	else:
		formMax=3
	print(formMax)
	
func _update_ending(direction:String)->void:
	_is_na_adj()
	print("entering update ending for noun")
	if direction == "up":
		if formID==formMax:
			formID=0
		else:
			formID+=1
	if direction == "down":
		if formID==0:
			formID=formMax
		else:
			formID-=1
	print(formID)
	_set_ending(StaticData.NounTable[formID])
	_update_reading()
