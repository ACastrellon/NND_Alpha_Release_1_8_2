extends VBoxContainer



var newWordVisSecne =preload("res://Scenes/WordVisual.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is WordVis:
		if _is_empty() and not(data._is_locked()):
			print("You can drop a Word here")
			var wordInWordVis = data._get_word_vis_word()
			var wordInWordFormID= wordInWordVis.formID
			#print("WordType:"+str(wordInWordVisType)+" FromID:"+str(wordInWordFormID))
			if wordInWordVis is Verb:
				if wordInWordVis.verbType =="godan" and int(wordInWordFormID) == 5 :
					return true
				elif wordInWordVis.verbType =="ichidan" and int(wordInWordFormID) == 2:
					return true
				else:
					return false
			elif wordInWordVis is Adjective and int(wordInWordFormID) == 3:
				return true
			elif wordInWordVis is Noun and int(wordInWordFormID)==0:
				return true
			else:
				return false
		else:
			print("The word you are trying to drop is locked to parent")
			return false
	else:
		print("You can only drop WordVis here")
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	_add_word_vis_to_machine(data)
	data.queue_free()
pass


func _add_word_vis_to_machine(wordVis:WordVis)->void:
	var newWordVis = newWordVisSecne.instantiate()
	newWordVis._set_word_vis_word(wordVis._get_word_vis_word())
	add_child(newWordVis)
	pass
	
func _is_empty()->bool:
	if get_child_count()<1:
		return true
	else:
		return false
		


func _on_cycle_time_tense_up_pressed() -> void:
	if not _is_empty():
		print("cycle word tense ending up")
		_cycle_word_vis_time_tense()
	else:
		print("bay is empty nothing to cycle")
	pass # Replace with function body.



func _on_cycle_time_tense_down_pressed() -> void:
	if not _is_empty():
		print("cycle word tense ending down")
		_cycle_word_vis_time_tense()
	else:
		print("bay is empty nothing to cycle")
	pass # Replace with function body.
	
	
func _cycle_word_vis_time_tense()->void:
	var wordVisInBay=get_child(0)
	var wordInWordVis=wordVisInBay._get_word_vis_word()
	wordInWordVis._cycle_word_time_tense()
	wordVisInBay._set_word_vis_word(wordInWordVis)
	if wordVisInBay.statusStamps.get_child_count()>0:
		wordVisInBay.statusStamps.get_child(0).queue_free()
	wordVisInBay.tenseStamps.get_child(1).queue_free()
	wordVisInBay.tenseStamps.get_child(0).queue_free()
	pass
	
	
