extends Control

@export var level_word_list: String
@export var WordBankNode: Control
@export var trainBay:VBoxContainer
@export var trainStation: HBoxContainer

var world_map_scene = "res://Scenes/LevelSelectScreen.tscn"
var newWordVisScene = preload("res://Scenes/WordVisual.tscn")

var wordList :Array[Word]
var train : Array[TrainLink]
var parsedJSON :Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parsedJSON=load_json_file(level_word_list)
	_load_words_from_json_file(parsedJSON)
	pass # Replace with function body.

func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile =FileAccess.open(filePath,FileAccess.READ)
		var parsedResult =JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("File does not exist")

func _load_words_from_json_file(inputDic:Dictionary)->void:
	var count = 0
	#print(StaticData.word_list)
	for i in inputDic:
		#print(count)
		var wordID = str(count)

		var newWord = _create_word_from_dic_info(inputDic[wordID])
		wordList.append(newWord)
		count+=1
		
	for i in wordList:
		i._print_english()
		var newWord = newWordVisScene.instantiate() 
		newWord._set_word_vis_word(i)
		WordBankNode.add_child(newWord)
	pass
	
func _create_word_from_dic_info(wordPacket:Dictionary)->Word:
	var resultWord:Word
	var wordType= wordPacket["word_type"]
	
	match wordType:
		"NOUN":
			resultWord = Noun.new()
			resultWord._set_english(wordPacket["english"])
			resultWord._set_reading(wordPacket["reading"])
			resultWord._set_word_prop_stamps(wordPacket["prop_stamps"])
			resultWord._set_word_status_stamps(wordPacket["status_stamps"])
			resultWord._set_word_tense_stamps(wordPacket["tense_stamps"])
			resultWord._set_word_comp_stamps(wordPacket["comp_stamps"])
			resultWord._set_root(wordPacket["root"])
			resultWord._set_ending(wordPacket["ending"])
			resultWord._set_form_ID(int(wordPacket["form_id"]))
			print("Printing NOUN from_id"+wordPacket["form_id"])
			resultWord._update_reading()
		"ADJ":
			resultWord = Adjective.new()
			resultWord._set_english(wordPacket["english"])
			resultWord._set_reading(wordPacket["reading"])
			resultWord._set_word_prop_stamps(wordPacket["prop_stamps"])
			resultWord._set_word_status_stamps(wordPacket["status_stamps"])
			resultWord._set_word_tense_stamps(wordPacket["tense_stamps"])
			print(wordPacket["comp_stamps"])
			resultWord._set_word_comp_stamps(wordPacket["comp_stamps"])
			resultWord._set_root(wordPacket["root"])
			resultWord._set_ending(wordPacket["ending"])
			resultWord._set_form_ID(int(wordPacket["form_id"]))
			print("Printing ADJ from_id"+wordPacket["form_id"])
			resultWord._update_reading()
		"VERB":
			resultWord = Verb.new()
			resultWord._set_english(wordPacket["english"])
			resultWord._set_reading(wordPacket["reading"])
			resultWord._set_word_prop_stamps(wordPacket["prop_stamps"])
			resultWord._set_word_status_stamps(wordPacket["status_stamps"])
			resultWord._set_word_tense_stamps(wordPacket["tense_stamps"])
			print(wordPacket["comp_stamps"])
			resultWord._set_word_comp_stamps(wordPacket["comp_stamps"])
			resultWord._set_root(wordPacket["root"])
			resultWord._set_ending(wordPacket["ending"])
			resultWord._set_verb_type(wordPacket["verb_type"])
			resultWord._set_consonant_ID(int(wordPacket["consonant_id"]))
			resultWord._set_form_ID(int(wordPacket["form_id"]))
			resultWord._update_reading()
			
	return resultWord
