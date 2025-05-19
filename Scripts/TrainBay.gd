extends VBoxContainer


#TrainBay.gd
@export var optionNode:OptionButton
@export var wordBankNode:WordBankVisual
#@export var signalLight: TextureRect

var newTrainVisualScene =preload("res://Scenes/TrainLinkVisual.tscn")
var newWordVisScene = preload("res://Scenes/WordVisual.tscn")
var badgeIndex = 0
var greenlight = preload("res://PNGs/Greenlight.png")
var redlight = preload("res://PNGs/Redlight.png")

func _is_empty()-> bool:
	var numOfChildren = get_child_count()
	if numOfChildren > 0:
		return false
	else:
		return true

func _get_selected_option()->int:
	var selectedOption = optionNode.get_selected_id()
	return selectedOption

func _get_train_vis_in_bay()->TrainLinkVis:
	if _is_empty():
		print("there is nothing in the bay")
		return null
	else:
		return get_child(0)

func _get_train_vis_in_bay_train_link()->TrainLink:
	return _get_train_vis_in_bay().trainLink

func _on_add_tlink_button_pressed() -> void:
	if _is_empty():
		print("adding a tlink to trainbay")
		match _get_selected_option():
			0: # Add Carriage
				_add_empty_carriage()
				pass
			1:# Add Engine
				_add_empty_engine()
				pass
	else:
		print("there is already a tlink in the trainbay")
	pass # Replace with function body.
	
func _on_delete_tlink_button_pressed() -> void:
	if _is_empty():
		print("trainbay is empty nothing to delete")
	else:
		print("deleting a tlink in the trainbay")
		var trainVisInBay =_get_train_vis_in_bay()
		if trainVisInBay is TrainLinkVis:
			if not(trainVisInBay.wordHolder._is_empty()):
				_add_word_in_train_vis_back_to_word_bank(trainVisInBay)
			trainVisInBay.queue_free()
			badgeIndex =0
			
	pass # Replace with function body.
	
func _on_cycle_badge_up_pressed() -> void:
	if _is_empty():
		print("trainbay is empty no badge to cycle")
	else:
		print("cycling badge up on the train link")
		var trainVisInBay=_get_train_vis_in_bay()
		var trainVisInBayTrainLink =_get_train_vis_in_bay_train_link()
		if trainVisInBayTrainLink is Carriage:
			print("We are working with a carriage")
			badgeIndex +=1
			if badgeIndex >6:
				badgeIndex =1
			trainVisInBayTrainLink._set_badge(StaticData.CarriageBadges[badgeIndex])
		elif trainVisInBayTrainLink is Engine_:
			print("We are working with a Engine")
			badgeIndex +=1
			if badgeIndex >3:
				badgeIndex =1
			if not(trainVisInBay._get_train_vis_train_link()._is_empty()):
				_add_word_in_train_vis_back_to_word_bank(trainVisInBay)
			trainVisInBay._set_train_vis_train_link(_make_engine_from_badge(badgeIndex))
		trainVisInBay._update_train_vis()
	pass # Replace with function body.
	
func _on_cycle_badge_down_pressed() -> void:
	if _is_empty():
		print("trainbay is empty no badge to cycle")
	else:
		print("cycling badge down the train link")
		var trainVisInBay=_get_train_vis_in_bay()
		var trainVisInBayTrainLink =_get_train_vis_in_bay_train_link()
		if trainVisInBayTrainLink is Carriage:
			print("We are working with a carriage")
			badgeIndex -=1
			if badgeIndex <1:
				badgeIndex =6
			trainVisInBayTrainLink._set_badge(StaticData.CarriageBadges[badgeIndex])
		elif trainVisInBayTrainLink is Engine_:
			print("We are working with a Engine")
			badgeIndex -=1
			if badgeIndex <1:
				badgeIndex =3
			if not(trainVisInBay._get_train_vis_train_link()._is_empty()):
				_add_word_in_train_vis_back_to_word_bank(trainVisInBay)
			trainVisInBay._set_train_vis_train_link(_make_engine_from_badge(badgeIndex))
		trainVisInBay._update_train_vis()
			
	pass # Replace with function body.

func _add_empty_carriage()->void:
	var newTrainVis = newTrainVisualScene.instantiate()
	var newTrainLinkWord = _add_empty_noun()
	var newTrainLink = Carriage.new(newTrainLinkWord)
	newTrainLink._set_badge("#")
	newTrainLink._set_train_link_color()
	newTrainVis._set_train_vis_train_link(newTrainLink) 
	newTrainVis._update_train_vis()
	add_child(newTrainVis)
	print("Added Empty Carriage")
	pass
	
func _add_empty_engine()->void:
	var newTrainVis = newTrainVisualScene.instantiate()
	var newTrainLinkWord = _add_empty_word()
	var newTrainLink = Engine_.new(newTrainLinkWord)
	newTrainLink._set_badge("#")
	newTrainLink._set_engine_type()
	newTrainLink._set_train_link_color()
	newTrainVis._set_train_vis_train_link(newTrainLink) 
	newTrainLink._print_TrainLink()
	newTrainVis._set_train_vis_texture(TrainLinkColors._get_train_link_texture(newTrainLink))
	newTrainVis._update_train_vis()
	add_child(newTrainVis)
	print("Added Empty Engine")
	pass

func _add_empty_noun()->Noun:
	var newNoun =Noun.new()
	newNoun._set_english("\u2205")
	newNoun._set_reading("\u2205")
	return newNoun

func _add_empty_word()->Word:
	var newWord= Word.new()
	newWord._set_english("\u2205")
	newWord._set_reading("\u2205")
	return newWord

func _add_empty_adj()->Adjective:
	var newAdjective= Adjective.new()
	newAdjective._set_english("\u2205")
	newAdjective._set_reading("\u2205")
	return newAdjective

func _add_empty_verb()->Verb:
	var newVerb= Verb.new()
	newVerb._set_english("\u2205")
	newVerb._set_reading("\u2205")
	return newVerb

func _make_engine_from_badge(badgeID:int)->Engine_:
	var newEngine
	match badgeID:
		1:
			newEngine = Engine_.new(_add_empty_noun())
		2:
			newEngine = Engine_.new(_add_empty_adj())
			#newEngine._set_badge(StaticData.EngineBadges[badgeIndex])
			#newEngine._set_train_link_color()
		3:
			newEngine = Engine_.new(_add_empty_verb())
			#newEngine._set_badge(StaticData.EngineBadges[badgeIndex])
			#newEngine._set_train_link_color()
	newEngine._set_badge(StaticData.EngineBadges[badgeIndex])
	newEngine._set_train_link_color()
	newEngine._set_engine_type()
	return newEngine


func _add_word_in_train_vis_back_to_word_bank(trainVis:TrainLinkVis)->void:
	var newWordVis
	if trainVis.wordHolder.get_child_count()>0:
		var oldWordVis =trainVis.wordHolder.get_child(0)
		newWordVis= oldWordVis._make_copy_of_self()
		oldWordVis.queue_free()
	wordBankNode.add_child(newWordVis)
	pass
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is TrainLinkVis:
		return true
	else:
		return false
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var newTrainCar=data._make_copy_of_self()
	if not(data.wordHolder._is_empty()):
		var wordVisInOldCar = data.wordHolder.get_child(0)
		newTrainCar.wordHolder.add_child(wordVisInOldCar._make_copy_of_self())
	add_child(newTrainCar)
	data.queue_free()

	
