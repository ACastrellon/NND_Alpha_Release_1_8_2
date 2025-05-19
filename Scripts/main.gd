extends Control

#main.gd

@export var WordBankNode: Control

var wordList :Array[Word]
var train : Array[TrainLink]
var world_map_scene = "res://Scenes/LevelSelectScreen.tscn"

var newWordVisScene = preload("res://Scenes/WordVisual.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_words_from_json_file()
	#_load_all_words()
	#_print_sentence()
 # Replace with function body.
pass

#func _load_all_words()->void:
#	newTrainLink= Carriage.new("GA", Noun.new("SAKURA"))
#	train.append(newTrainLink)
#	newTrainLink =Engine_.new("COPULA", Noun.new("GAKUSEI"))
#	train.append(newTrainLink)
#	newTrainLink =Engine_.new("ADJ", Adjective.new("KASHIKOI"))
#	train.append(newTrainLink)
#	newTrainLink =Engine_.new("VERB", Verb.new("YOMU"))
#	train.append(newTrainLink)
#	for i in train:
#		i._print_TrainLink()
#	pass

#func _print_sentence()->void:
#	var sentence: String
#	for i in train:
#		sentence+=i._get_english()
#	print(sentence)

func _load_words_from_json_file()->void:
	var count = 0
	#print(StaticData.word_list)
	for i in StaticData.word_list:
		#print(count)
		var wordID = str(count)
		#var wordType = StaticData.word_list[wordID]["word_type"]
		#print(wordType)
		#wordList.append()
		var newWord = _create_word_from_dic_info(StaticData.word_list[wordID])
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


func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file(world_map_scene)
	pass # Replace with function body.
