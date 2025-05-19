extends ColorRect

#word_visual.gd

class_name WordVis

@export var wordReading: Label
@export var wordEnglish: Label
@export var wordColor: ColorRect
#@export var topStamps: HBoxContainer
@export var compStamps: VBoxContainer
@export var propStamps: HBoxContainer
@export var tenseStamps: HBoxContainer
@export var statusStamps: VBoxContainer
@export var dragButtton:Button

var wordVisWord: Word
var stampScene = preload("res://Scenes/stamp_visual.tscn")
var newWordVisScene =preload("res://Scenes/WordVisual.tscn")

var isLocked = false

func _set_reading_label(text: String)->void:
	wordReading.set_text(text)

func _set_english_label(text: String)->void:
	wordEnglish.set_text(text)

func _set_word_vis_color(inputColor:Color)->void:
	wordColor.color=inputColor

func _set_word_vis_word(inputWord:Word)->void:
	var inputWordType= inputWord._get_word_type()
	var inputWordEnglish= inputWord._get_english()
	var inputWordReading= inputWord._get_reading()
	var inputWordPropStamps =inputWord._get_word_prop_stamps()
	var inputWordStatusStamps =inputWord._get_word_status_stamps()
	var inputWordTenseStamps =inputWord._get_word_tense_stamps()
	var inputWordTimeTense =inputWord._get_word_time_tense()
	var inputWordCompStamps =inputWord._get_word_comp_stamps()
	print("printing initializing:"+inputWordTimeTense)
	
	match inputWordType:
		"NOUN":
			wordVisWord = Noun.new() #sets the word type in constructor
			wordVisWord._set_reading(inputWordReading)
			wordVisWord._set_english(inputWordEnglish)
			wordVisWord._set_word_prop_stamps(inputWordPropStamps)
			wordVisWord._set_word_status_stamps(inputWordStatusStamps)
			wordVisWord._set_word_tense_stamps(inputWordTenseStamps)
			wordVisWord._set_word_comp_stamps(inputWordCompStamps)
			wordVisWord._set_root(inputWord.root)
			wordVisWord._set_ending(inputWord.ending)
			wordVisWord._set_form_ID(inputWord.formID)
			wordVisWord._set_word_time_tense(inputWordTimeTense)
			
		"ADJ":
			wordVisWord = Adjective.new() # sets the word type in constructor
			wordVisWord._set_reading(inputWordReading)
			wordVisWord._set_english(inputWordEnglish)
			wordVisWord._set_word_prop_stamps(inputWordPropStamps)
			wordVisWord._set_word_status_stamps(inputWordStatusStamps)
			wordVisWord._set_word_tense_stamps(inputWordTenseStamps)
			wordVisWord._set_word_comp_stamps(inputWordCompStamps)
			wordVisWord._set_root(inputWord.root)
			wordVisWord._set_ending(inputWord.ending)
			wordVisWord._set_form_ID(inputWord.formID)
			wordVisWord._set_word_time_tense(inputWordTimeTense)
		"VERB":
			wordVisWord = Verb.new()# sets the word type in constructor
			wordVisWord._set_reading(inputWordReading)
			wordVisWord._set_english(inputWordEnglish)
			wordVisWord._set_word_prop_stamps(inputWordPropStamps)
			wordVisWord._set_word_status_stamps(inputWordStatusStamps)
			wordVisWord._set_word_tense_stamps(inputWordTenseStamps)
			wordVisWord._set_word_comp_stamps(inputWordCompStamps)
			wordVisWord._set_root(inputWord.root)
			wordVisWord._set_ending(inputWord.ending)
			wordVisWord._set_verb_type(inputWord._get_verb_type())
			wordVisWord._set_consonant_ID(inputWord.consonantID)
			wordVisWord._set_form_ID(inputWord.formID)
			wordVisWord._set_word_time_tense(inputWordTimeTense)
			
	_set_english_label(wordVisWord._get_english())
	_set_reading_label(wordVisWord._get_reading())
	_set_word_vis_color(WordColors._get_word_color(wordVisWord))
	_set_prop_stamps()
	_set_status_stamps()
	_set_comp_stamps()
	_set_time_tense_stamps()
	
	
func _get_word_type()->String:
	return wordVisWord._get_word_type()

func _get_word_vis_word()->Word:
	return wordVisWord

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(_get_preview_control(wordColor.color))
	return self

func _set_prop_stamps()->void:
	var stampList = wordVisWord.propStamps
	print(stampList)
	#print(not(stampList == "noun"))
	#print(not(stampList == "adj"))
	if stampList.size() != propStamps.get_child_count():
		if not(stampList[0] == "none"): #and not(stampList[0] == "adj"):
			for i in stampList:
				var newStampScene=stampScene.instantiate()
				newStampScene._set_stamp_texture(StampColors._get_prop_stamp_texture(i))
				newStampScene._set_stamp_label(StaticData.PropStampLabelDic[i])
				propStamps.add_child(newStampScene)
	pass

func _set_status_stamps()->void:
	var stampList = wordVisWord.statusStamps
	print(stampList)
	#print(not(stampList == "noun"))
	#print(not(stampList == "adj"))
	if stampList.size()>0: #and propStamps.get_child_count()<1:
		if not(stampList[0] == "none"): #and not(stampList[0] == "adj"):
			for i in stampList:
				var newStampScene=stampScene.instantiate()
				newStampScene._set_stamp_texture(StampColors._get_status_stamp_texture(wordVisWord))
				newStampScene._set_stamp_label(StaticData._get_status_label(wordVisWord))
				statusStamps.add_child(newStampScene)
			#wordVisWord.statusStamps.remove_at(0)
			
	pass
	
func _set_time_tense_stamps()->void:
	var stampList = wordVisWord.tenseStamps
	print(stampList)
	#print(not(stampList == "noun"))
	#print(not(stampList == "adj"))
	if stampList.size()>0: #and propStamps.get_child_count()<1:
		if not(stampList[0] == "none"): #and not(stampList[0] == "adj"):
			if stampList[1] == "non-past" or stampList[1] == "past":
				var newStampScene=stampScene.instantiate()
				newStampScene._set_stamp_texture(StampColors._get_time_tense_stamp_texture(wordVisWord._get_word_time_tense()))
				newStampScene._set_stamp_label(StaticData._get_time_tense_label(wordVisWord._get_word_time_tense()))
				tenseStamps.add_child(newStampScene)
			if stampList[0] == "positive" or stampList[0] == "negative":
				var newStampScene=stampScene.instantiate()
				newStampScene._set_stamp_texture(StampColors._get_polarity_stamp_texture(wordVisWord._get_word_polarity()))
				newStampScene._set_stamp_label(StaticData._get_polarity_label(wordVisWord._get_word_polarity()))
				tenseStamps.add_child(newStampScene)
			#wordVisWord.statusStamps.remove_at(0)
	pass
	
func _set_comp_stamps()->void:
	var stampList = wordVisWord.compStamps
	if stampList.size() != compStamps.get_child_count():
		if stampList[0] != "none":
			for i in stampList:
				var newStampScene=stampScene.instantiate()
				newStampScene._set_stamp_texture(StampColors._get_comp_stamp_texture(i))
				newStampScene._set_stamp_label(StaticData._get_comp_label(i))
				compStamps.add_child(newStampScene)
	pass
	
	
func _update_status_stamps()->void:
	var stampList = wordVisWord.statusStamps
	statusStamps.get_child(0)._set_stamp_label(StaticData.StatusStampLabelDic[int(stampList[0])])
	pass


func _make_copy_of_self()->WordVis:
	var newCopyofWordVis = newWordVisScene.instantiate()
	newCopyofWordVis._set_word_vis_word(wordVisWord)
	return newCopyofWordVis

func _lock_to_parent()->void:
	print("locked to parent")
	isLocked =true

func _unlock_from_parent()->void:
	print("unlocked from parent")
	isLocked =false

func _is_locked()->bool:
	return isLocked

func _update_home_position()->void:
	dragButtton._update_home_position()
	pass

func _get_preview_control(pColor: Color)-> Control:
	var preview = ColorRect.new()
	preview.size.x = 170
	preview.size.y = 100
	preview.color = pColor
	preview.color.a =.5
	preview.set_rotation(0.1)
	return preview
	
