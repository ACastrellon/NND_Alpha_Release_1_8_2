extends Word

class_name Adjective

#Adjective.gd

# Variables Inherited from Word Class
# wordType: String
# english: String
# reading: String
#See Word Class for additional information

#Adjective specific variables
#---------------------------------

# Functions inherited from Word Class
#  _get_word_type()-> String: 
#  _get_english()->String:
# _get_reading()->String:
# _set_word_type()-> void:
# _print_word()->void:
# _print_english()->void
#_print_reading()->void:

# See Word Class for additional information

var root
var ending
#var formID

# Functions overridden by Adjective Class
func _init()->void:
	wordType ="ADJ"
	#english =adjText

func _cycle_adj(direction:String)->void:
	_update_ending(direction)

func _set_root(inputString:String)->void:
	root=inputString

func _set_ending(inputString:String)->void:
	ending=inputString

func _set_form_ID(inputInt:int)->void:
	formID =inputInt

func _update_reading():
	reading= root+ending

func _update_ending(direction:String)->void:
	print("entering update ending for adjective")
	if direction == "up":
		if formID==3:
			formID=0
		else:
			formID+=1
	if direction == "down":
		if formID==0:
			formID=3
		else:
			formID-=1
	_set_ending(StaticData.IAdjectiveTable[formID])
	_update_reading()
# Will define other properties of Verb in later on

func _get_root()->String:
	return root

func _get_ending()->String:
	return ending

func _get_formID()->int:
	return formID

func _cycle_word_time_tense()->void:
	#print("1.TIME TENSE going IN: "+timeTense)
	if _get_word_time_tense()=="non-past":
		#print("2.it is in fact Non-past")
		#print("3.setting to present")
		_set_word_time_tense("past")
		#print("4.ran _set_word_time_tesne")
		#print("5.Checking if ends with で"+str(ending.ends_with("で")))
		_set_ending(ending+"かった")
		
	elif _get_word_time_tense()=="past":
		_set_word_time_tense("non-past")
		_set_ending(ending.substr(0,ending.length()-3))
	#print("6.cycling time tense")
	#print("7.TIME TENSE going OUT: "+timeTense)
	#print("8.ENDING: "+ending)
	_update_reading()

# Will define other properties of Adjectives in later on
