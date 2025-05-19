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
var train1: Array[Word]
var train2: Array[Word]
var train3: Array[Word]

var objective1_complete= false # Add Carriage
var objective2_complete= false # Cycle Carriage Badge
var objective3_complete= false # Add Noun to Carriage
var objective4_complete= false # Add Completed Train Car to Engine
var objective5_complete= false # Add Engine
var objective6_complete= false # Cycle Engine Badge
var objective7_complete= false # Add Adjective to Engine
var objective8_complete= false # Add Engine to Train
var objective9_complete= false # Moved Engine to Back of Train
var objective10_complete= false # Add Verb Engine to front of Train
var objective11_complete= false # Delete a Train Car

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parsedJSON=load_json_file(level_word_list)
	_load_words_from_json_file(parsedJSON)
	print("Starting Timeline")
	#is_really_ready =true
	Dialogic.start("res://Timelines/Tutorial.dtl")	
	
	train1.append(Noun.new())
	train1[0]._set_english("SAKURA-SAN")
	train1.append(Adjective.new())
	train1[1]._set_english("INTELLIGENT")
	
	train2.append(train1[1])
	train2.append(train1[0])
	
	train3.append_array(train2)
	train3.append(Verb.new())
	train3[2]._set_english("READ")
	
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

func _added_a_carriage()->void:
	Dialogic.start_timeline("res://Timelines/CyclyingBadge.dtl")

func _added_a_engine()->void:
	Dialogic.start_timeline("res://Timelines/CycleEngineBadge.dtl")

func _on_train_bay_child_order_changed() -> void:
	if is_instance_valid(trainBay) && is_instance_valid(trainStation) && is_instance_valid(WordBankNode):
		if objective1_complete == false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link() is Carriage:
				_added_a_carriage()
				objective1_complete =true
		if objective4_complete && objective5_complete== false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link() is Engine_:
				_added_a_engine()
				objective5_complete =true
		pass # Replace with function body.

	#print_rich("[color=GREEN]Train Station Settled?:"+str(trainStation.settled)+"[/color]")
	
		if trainBay._is_empty() && trainStation.get_child_count()==2 && objective8_complete== false:
			var count= 0
			print_rich("[rainbow]Checking for objective 8[/rainbow]")
			for i in train1:
				print_rich(trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english())
				print_rich(i._get_english())
				if trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english() == i._get_english():
					objective8_complete= true
				else:
					objective8_complete =false
				count+=1
			if objective8_complete:
				_engine_added_to_station()
		#print_rich("[color=RED]Train Station Settled?:"+str(trainStation.settled)+"[/color]")
		if trainBay._is_empty() && trainStation.get_child_count()==3 && objective10_complete==false :
			var count= 0
			print_rich("[rainbow]Checking for objective 10[/rainbow]")
			for i in train3:
				print_rich(trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english())
				print_rich(i._get_english())
				if trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english() == i._get_english():
					objective10_complete= true
				else:
					objective10_complete=false
				count+=1
			if objective10_complete:
				_added_verb_to_train()
					
		if objective10_complete && objective11_complete== false:
			if WordBankNode.get_child_count()==1 && trainBay._is_empty():
				_deleted_train_car()
				objective11_complete= true


func _cycled_carriage_badge()->void:
	Dialogic.start_timeline("res://Timelines/TrainCarRules.dtl")

func _cycled_engine_badge()->void:
	Dialogic.start_timeline("res://Timelines/EngineRules.dtl")
	
func _word_added_to_carriage()->void:
	print("Word Added to Carriage")
	Dialogic.start_timeline("res://Timelines/AddingToTrainStation.dtl")


func _word_added_to_engine()->void:
	print("Word Added to Engine")
	Dialogic.start_timeline("res://Timelines/AddEngineToTrain.dtl")


func _carriage_added_to_station()->void:
	Dialogic.start_timeline("res://Timelines/AddEngineToBay.dtl")
	pass

func _engine_added_to_station()->void:
	Dialogic.start_timeline("res://Timelines/TrainCarPositions.dtl")
	pass
	
func _moved_engine()->void:
	Dialogic.start_timeline("res://Timelines/AddVerbEngine.dtl")
	pass

func _added_verb_to_train()->void:
	Dialogic.start_timeline("res://Timelines/DeleteTrainCars.dtl")
	
func _deleted_train_car()->void:
	Dialogic.start_timeline("res://Timelines/TutorialComplete.dtl")

func _on_cycle_badge_up_pressed() -> void:
	if is_instance_valid(trainBay):
		if objective2_complete==false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link()._get_train_link_badge() == "が":
				_cycled_carriage_badge()
				objective2_complete= true
		if objective5_complete && objective6_complete==false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link()._get_train_link_badge() == "い":
				_cycled_engine_badge()
				objective6_complete= true
		pass # Replace with function body.

func _on_cycle_badge_down_pressed() -> void:
	if is_instance_valid(trainBay):
		if objective2_complete==false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link()._get_train_link_badge() == "が":
				_cycled_carriage_badge()
				objective2_complete= true
		if objective5_complete && objective6_complete==false:
			if not(trainBay._is_empty()) and trainBay._get_train_vis_in_bay()._get_train_vis_train_link()._get_train_link_badge() == "い":
				_cycled_engine_badge()
				objective6_complete= true
		pass # Replace with function body.


func _on_word_bank_node_child_order_changed() -> void:
	if is_instance_valid(WordBankNode):
		if  objective2_complete && objective3_complete==false:
			print("Number of Childs: "+str(WordBankNode.get_child_count()))
			if WordBankNode.get_child_count()<3:
				_word_added_to_carriage()
				objective3_complete= true
		if  objective6_complete && objective7_complete==false:
			print("Number of Childs: "+str(WordBankNode.get_child_count()))
			if WordBankNode.get_child_count()<2:
				_word_added_to_engine()
				objective7_complete= true
		pass # Replace with function body.


func _on_trainstation_child_order_changed() -> void:
	if is_instance_valid(trainBay) && is_instance_valid(trainStation) && is_instance_valid(WordBankNode):
		if objective4_complete==false :
			if trainStation.get_child_count()>0:
				_carriage_added_to_station()
				objective4_complete= true
				
		if trainBay._is_empty() && trainStation.get_child_count()==2 && objective8_complete== false:
			var count= 0
			print_rich("[rainbow]Checking for objective 8[/rainbow]")
			for i in train1:
				print_rich(trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english())
				print_rich(i._get_english())
				if trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english() == i._get_english():
					objective8_complete= true
				else:
					objective8_complete =false
				count+=1
			if objective8_complete:
				_engine_added_to_station()
			print_rich("[color=RED]Train Station Settled?:"+str(trainStation.settled)+"[/color]")
			
		if Dialogic.VAR.TutorialVariables.OtherFlag && objective9_complete==false :
			var count= 0
			print_rich("[rainbow]Checking for objective 9[/rainbow]")
			for i in train2:
				print_rich(trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english())
				print_rich(i._get_english())
				if trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english() == i._get_english():
					objective9_complete= true
				else:
					objective9_complete=false
				count+=1
			if objective9_complete:
				_moved_engine()
				

		if trainBay._is_empty() && trainStation.get_child_count()==3 && objective10_complete==false :
			var count= 0
			print_rich("[rainbow]Checking for objective 10[/rainbow]")
			for i in train3:
				print_rich(trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english())
				print_rich(i._get_english())
				if trainStation.get_child(count)._get_train_vis_train_link()._get_train_link_word()._get_english() == i._get_english():
					objective10_complete= true
				else:
					objective10_complete=false
				count+=1
			if objective10_complete:
				_added_verb_to_train()
		pass # Replace with function body.
	
	
func _on_exit_to_level_select_pressed() -> void:
	get_tree().change_scene_to_file(world_map_scene)
	pass # Replace with function body.
