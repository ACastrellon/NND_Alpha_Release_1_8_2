extends VBoxContainer


#adjective_bay.gd

var newWordVisSecne =preload("res://Scenes/WordVisual.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is WordVis:
		if data._get_word_vis_word() is Adjective and _is_empty() and not(data._is_locked()) and data._get_word_vis_word()._get_word_time_tense() != "past":
			print("You can drop a Adjective here")
			return true
		else:
			print("The word you are trying to drop is not a adj")
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
	

func _on_cycle_ending_up_pressed() -> void:
	if not _is_empty():
		print("cycle adjective ending up")
		_cycle_adj("up")
	else:
		print("bay is empty nothing to cycle")
	pass # Replace with function body.


func _on_cycle_ending_down_pressed() -> void:
	if not _is_empty():
		print("cycle adjective ending down")
		_cycle_adj("down")
	else:
		print("bay is empty nothing to cycle")
	pass # Replace with function body.

func _cycle_adj(direction:String)->void:
	var wordVisInBay=get_child(0)
	var adjInWordVis=wordVisInBay._get_word_vis_word()
	adjInWordVis._cycle_adj(direction)
	wordVisInBay._set_word_vis_word(adjInWordVis)
	wordVisInBay.statusStamps.get_child(0).queue_free()
	wordVisInBay.tenseStamps.get_child(1).queue_free()
	wordVisInBay.tenseStamps.get_child(0).queue_free()
	
	pass
