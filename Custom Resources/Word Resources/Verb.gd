extends Word
#Verb.gd

class_name Verb
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
var consonantID
#var formID
var verbType

# Functions overridden by Verb Class
func _init()->void:
	wordType ="VERB"
	#english =verbText

func _cycle_verb(direction:String)->void:
	_cycle_verb_form(direction)
	_update_status_stamps(direction)


func _set_root(inputString:String)->void:
	root=inputString

func _set_ending(inputString:String)->void:
	ending=inputString

func _set_verb_type(inputString:String)->void:
	verbType=inputString

func _set_consonant_ID(inputInt:int)->void:
	consonantID =inputInt

func _set_form_ID(inputInt:int)->void:
	formID =inputInt

func _update_reading():
	reading= root+ending

func _cycle_verb_form(direction:String)->void:
	if verbType=="ichidan":
		if direction == "up":
			if formID==2:
				formID=0
			else:
				formID+=1
		if direction == "down":
			if formID==0:
				formID=2
			else:
				formID-=1
		_set_ending(StaticData.IchidanVerbTable[formID])
	
	if verbType=="godan":
		if direction == "up":
			if formID==5:
				formID=0
			else:
				formID+=1
		if direction == "down":
			if formID==0:
				formID=5
			else:
				formID-=1
		_set_ending(StaticData.GodanVerbTable[consonantID][formID])
	_update_reading()
# Will define other properties of Verb in later on

func _get_root()->String:
	return root

func _get_ending()->String:
	return ending

func _get_consonantID()->int:
	return consonantID

func _get_formID()->int:
	return formID
	
func _update_status_stamps(direction:String)->void:
	if direction == "up":
			if int(statusStamps[0])==5:
				_set_status_stamps("0")
			else:
				_set_status_stamps(str(int(statusStamps[0])+1))
	if direction == "down":
		if int(statusStamps[0])==0:
			_set_status_stamps("5")
		else:
			_set_status_stamps(str(int(statusStamps[0])-1))

func _set_status_stamps(inputString:String)->void:
	statusStamps[0]= inputString

func _get_verb_type()->String:
	return verbType

func _cycle_word_time_tense()->void:
	#print("1.TIME TENSE going IN: "+timeTense)
	if _get_word_time_tense()=="non-past":
		#print("2.it is in fact Non-past")
		#print("3.setting to present")
		_set_word_time_tense("past")
		#print("4.ran _set_word_time_tesne")
		#print("5.Checking if ends with で"+str(ending.ends_with("で")))
		if ending.ends_with("て"):
			_set_ending(ending.substr(0,ending.length()-1)+"た")
		if ending.ends_with("で"):
			_set_ending(ending.substr(0,ending.length()-1)+"だ")
	elif _get_word_time_tense()=="past":
		_set_word_time_tense("non-past")
		if ending.ends_with("た"):
			ending = ending.substr(0,ending.length()-1)+"て"
		else:
			ending = ending.substr(0,ending.length()-1)+"で"
	#print("6.cycling time tense")
	#print("7.TIME TENSE going OUT: "+timeTense)
	#print("8.ENDING: "+ending)
	_update_reading()
	#print("9.READING:"+reading)

	

#func _update_time_tense_stamps(inputString:String)->void:
