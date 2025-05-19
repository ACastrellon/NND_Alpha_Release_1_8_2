extends TextureRect

#TrainLinkVisual.gd

class_name TrainLinkVis

@export var trainVisualTexture:TextureRect
@export var trainVisualBadge:Label
@export var wordHolder:HBoxContainer

var trainLink:TrainLink

var newTrainVisScene=preload("res://Scenes/TrainLinkVisual.tscn")


func _set_train_vis_texture(inputTexture: Texture2D)->void:
	trainVisualTexture.texture =inputTexture


func _set_train_vis_badge(inputString:String)->void:
	trainVisualBadge.set_text(inputString)
	_update_badge_color()
		
func _set_train_vis_train_link(inputTlink:TrainLink)->void:
	var tlinkType = inputTlink._get_train_link_type()
	var tlinkWord = inputTlink._get_train_link_word()
	var tlinkBadge =inputTlink._get_train_link_badge()
	
	print("Entered _set_train_vis_badge_vis_train_link")
	print(tlinkBadge)
	match tlinkType:
		"ENGINE":
			trainLink = Engine_.new(tlinkWord)
			#trainLink._set_badge(tlinkBadge)
			pass
		"CARRIAGE":
			trainLink = Carriage.new(tlinkWord)
			#trainLink._set_badge(tlinkBadge)
			pass
	trainLink._set_badge(tlinkBadge)
	print("acceptable word type from trainlink")
	print(trainLink._get_acceptable_word_type())
	
func _get_train_vis_train_link()->TrainLink:
	
	return trainLink
	#trainLink._set_train_link_color("")

func _update_badge_color()->void:
	if trainLink._get_train_link_color() == "BLACK":
		trainVisualBadge.add_theme_color_override("font_color",Color.WHITE)
	else:
		trainVisualBadge.add_theme_color_override("font_color",Color.BLACK)

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(_get_preview_control(trainVisualTexture.texture))
	return self


# may need these funtions for the TrainStation positioning
func _update_train_vis()->void:
	var tlinkWord= trainLink._get_train_link_word()
	trainLink._set_train_link_color()
	_set_train_vis_badge(trainLink._get_train_link_badge())
	_set_train_vis_texture(TrainLinkColors._get_train_link_texture(trainLink))
	#print(tlinkWord._get_word_top_stamps())
	trainLink._print_TrainLink()
	print(trainLink._is_valid_train_link())
	pass

func _update_train_vis_color(inputColor:String)->void:
	if trainLink is Engine_:
		trainLink._update_train_link_color(inputColor)
	_set_train_vis_texture(TrainLinkColors._get_train_link_texture(trainLink))
	pass
	
			
func _make_copy_of_self()->TrainLinkVis:
	var newTrainVis
	var trainVisTrainLink = _get_train_vis_train_link()
	if trainVisTrainLink is Carriage:
		newTrainVis = newTrainVisScene.instantiate()
		var newTrainLinkWord = trainVisTrainLink._get_train_link_word()
		var newTrainLink = Carriage.new(newTrainLinkWord)
		newTrainLink._set_badge(trainVisTrainLink._get_train_link_badge())
		newTrainLink._set_train_link_color()
		newTrainVis._set_train_vis_train_link(newTrainLink) 
		newTrainVis._update_train_vis()
		print("Added Carriage")
	elif trainVisTrainLink is Engine_:
		newTrainVis = newTrainVisScene.instantiate()
		var newTrainLinkWord = trainVisTrainLink._get_train_link_word()
		var newTrainLink = Engine_.new(newTrainLinkWord)
		newTrainLink._set_badge(trainVisTrainLink._get_train_link_badge())
		newTrainLink._set_engine_type()
		newTrainLink._set_train_link_color()
		newTrainVis._set_train_vis_train_link(newTrainLink) 
		newTrainLink._print_TrainLink()
		newTrainVis._set_train_vis_texture(TrainLinkColors._get_train_link_texture(newTrainLink))
		newTrainVis._update_train_vis()
		print("AddedEngine")
	return newTrainVis

func _set_to_empty_train_link()->void:
	if trainLink is Carriage:
		trainLink = Carriage.new(Noun.new())
	elif trainLink is Engine_:
		trainLink = Engine_.new(Word.new())
		
func _get_preview_control(t:Texture2D)->Control:
	var preview = TextureRect.new()
	preview.texture= t
	preview.self_modulate.a = 0.5
	preview.set_rotation(0.1)
	preview.set_scale(Vector2(0.3,0.3)) 
	return preview
