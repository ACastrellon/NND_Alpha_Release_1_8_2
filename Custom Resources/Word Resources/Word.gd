extends Resource
class_name Word

#Word.gd

var wordType: String 
var english: String
var reading: String
var propStamps: Array
var statusStamps: Array
var tenseStamps: Array
var compStamps: Array
var polarity:String
var timeTense:String
var formID: int

func _init()->void:
	wordType = "WORD"
	english = "\u2205"
	reading = "\u2205"


func _get_word_type()-> String:
	return wordType

func _get_english()->String:
	return english

func _get_reading()->String:
	return reading

func _set_word_type(wt:String)-> void:
	wordType=wt
	#not sure if this will be necessary
func _set_reading(inputText:String)->void:
	reading =inputText
	
func _set_english(inputText:String)->void:
	english = inputText

func _print_word() -> void: 
	# Print in the command line
	print("English:"+english)
	print("Reading:"+ reading)
	print("Word Type:"+wordType)
	
func _print_english()-> void:
	#print in the command line
	print(english)
	
func _print_reading()->void:
	#print in the command line
	print(reading)

func _is_empty()->bool:
	if english == "\u2205":
		return true
	else:
		return false
		
func _set_word_prop_stamps(stampArray:Array)->void:
	propStamps=stampArray
	print(propStamps)
	pass
	
func _get_word_prop_stamps()->Array:
	return propStamps
pass

func _set_word_status_stamps(stampArray:Array)->void:
	statusStamps=stampArray
	print(statusStamps)
	pass
	
func _get_word_status_stamps()->Array:
	return statusStamps
pass

func _set_word_tense_stamps(stampArray:Array)->void:
	tenseStamps=stampArray
	_set_word_polarity(tenseStamps[0])
	_set_word_time_tense(tenseStamps[1])
	print(tenseStamps)

func _get_word_tense_stamps()->Array:
	return tenseStamps

func _set_word_polarity(inputString:String)->void:
	polarity =inputString
	
func _get_word_polarity()->String:
	return polarity

func _set_word_time_tense(inputString:String)->void:
	print("executing _set_word_time_tense")
	print("Printing inputString:"+inputString)
	timeTense = inputString
	print("Printing timeTense:"+timeTense)

func _get_word_time_tense()->String:
	return timeTense

func _cycle_word_time_tense()->void:
	pass

func _set_word_comp_stamps(stampArray:Array)->void:
	compStamps =stampArray
	pass
	
func _get_word_comp_stamps()->Array:
	return compStamps
