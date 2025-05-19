extends HBoxContainer

#WordBankVisual.gd

class_name WordBankVisual
# Called when the node enters the scene tree for the first time.
var newWordVisScene = preload("res://Scenes/WordVisual.tscn")

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	#if data is TrainLinkVis:
		#if not(data._get_train_vis_train_link().trainLinkWord._is_empty()):
			#return true
		#else:
			#return false
	#else:
	if data is WordVis and not(data._is_locked()):
		return true
	else:
		return false
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	#if data is TrainLinkVis:
		#var trainVisTrainLink = data._get_train_vis_train_link()
		#var trainVisTrainLinkWord =trainVisTrainLink._get_train_link_word()
		#
		#var wordType= trainVisTrainLink._get_acceptable_word_type()
		#
		#var resultWord
		#
		#match wordType:
			#"NOUN":
				#resultWord = Noun.new()
				#resultWord._set_english(trainVisTrainLinkWord._get_english())
				#resultWord._set_reading(trainVisTrainLinkWord._get_reading())
#
			#"ADJ":
				#resultWord = Adjective.new()
				#resultWord._set_english(trainVisTrainLinkWord._get_english())
				#resultWord._set_reading(trainVisTrainLinkWord._get_reading())
#
			#"VERB":
				#resultWord = Verb.new()
				#resultWord._set_english(trainVisTrainLinkWord._get_english())
				#resultWord._set_reading(trainVisTrainLinkWord._get_reading())
				#resultWord._set_word_top_stamps(trainVisTrainLinkWord.wordStamps)
				#resultWord._set_root(trainVisTrainLinkWord._get_root())
				#resultWord._set_ending(trainVisTrainLinkWord._get_ending())
				#resultWord._set_consonant_ID(trainVisTrainLinkWord._get_consonantID())
				#resultWord._set_form_ID(trainVisTrainLinkWord._get_formID())
		#
		#trainVisTrainLinkWord._set_reading("\u2205")
		#trainVisTrainLinkWord._set_english("\u2205")
		#if trainVisTrainLinkWord.wordStamps.size()>1:
			#for i in trainVisTrainLinkWord.wordStamps:
				#i.queue_free()
		#data._update_train_vis()
		#
		#var newWordVis= newWordVisScene.instantiate() 
		#newWordVis._set_word_vis_word(resultWord)
		#add_child(newWordVis)
		
	if data is WordVis:
		var newWordVis = data._make_copy_of_self()
		#var oldWordVisWordHolder = data.get_parent()
		#var oldTrainLinkVisFromWordHolder = oldWordVisWordHolder.get_parent()
		#oldTrainLinkVisFromWordHolder.trainLink._print_TrainLink()
		#if oldTrainLinkVisFromWordHolder is TrainLinkVis:
			#oldTrainLinkVisFromWordHolder._set_to_empty_train_link()
				#var newEmptyEngine = Engine_.new(Word.new())
				#oldTrainLinkVisFromWordHolder._set_train_vis_train_link(newEmptyEngine)
				#oldTrainLinkVisFromWordHolder._update_train_vis()
			#if oldTrainLinkVisFromWordHolder._get_train_vis_train_link() is Engine_:
				#var newEmptyCarraige = Carriage.new(Noun.new())
				#oldTrainLinkVisFromWordHolder._set_train_vis_train_link(newEmptyCarraige)
				#oldTrainLinkVisFromWordHolder._update_train_vis()
			#data._get_node("TrainLinkTextureRect")._set_train_vis_train_link(inputTlink:TrainLink)->void:
		#_add_word_vis_to_word_bank(newTrainVis)
		add_child(newWordVis)
		data.queue_free()

#func _add_word_vis_to_word_bank(wordVis:WordVis)->void:
	#var newWordVis = newWordVisScene.instantiate()
	#newWordVis._set_word_vis_word(wordVis._get_word_vis_word())
	#add_child(newWordVis)
	#pass
