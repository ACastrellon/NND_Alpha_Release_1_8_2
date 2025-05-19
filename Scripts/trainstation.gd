extends HBoxContainer

var newTrainVisualScene =preload("res://Scenes/TrainLinkVisual.tscn")
var newWordVisSecne =preload("res://Scenes/WordVisual.tscn")

@export var new_train_offset: float
@export var old_train_offset: float

#trainstation.gd

var settled=false

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is TrainLinkVis and not(data.wordHolder._is_empty()):
		print("You can drop in this train station")
		return true
	else:
		print("You can NOT drop in this train station")
		return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	settled= false
	var newTrainCar=data._make_copy_of_self()
	if not(data.wordHolder._is_empty()):
		var wordVisInOldCar = data.wordHolder.get_child(0)
		newTrainCar.wordHolder.add_child(wordVisInOldCar._make_copy_of_self())
		newTrainCar.wordHolder.get_child(0)._lock_to_parent()
	_set_train_vis_at_index(newTrainCar,at_position)
	settled =true
	data.queue_free()

func _update_train_vis_colors()->void:
	var count=0;
	for tlinkvis in get_children():
		var tlinkInVis =tlinkvis._get_train_vis_train_link()
		if tlinkInVis is Engine_ :
			if count < get_child_count()-1:
				tlinkInVis._update_train_link_color("WHITE")
				tlinkvis._set_train_vis_texture(TrainLinkColors._get_train_link_texture(tlinkInVis))
				tlinkvis._update_badge_color()
			else:
				tlinkInVis._update_train_link_color("BLACK")
				tlinkvis._set_train_vis_texture(TrainLinkColors._get_train_link_texture(tlinkInVis))
				tlinkvis._update_badge_color()
		count +=1
	pass

func _on_child_order_changed() -> void:
	settled= false
	_update_train_vis_colors()
	var train =""
	for tlinkvis in get_children():
		var tlinkvisTrainLink = tlinkvis._get_train_vis_train_link()
		var tlinkword = tlinkvisTrainLink._get_train_link_word()
		if tlinkword._get_word_time_tense() == "past":
			train=train+tlinkvisTrainLink._get_english()+"(PAST)"
		else:
			train=train+tlinkvisTrainLink._get_english()
	print(train)
	settled= true
	pass # Replace with function body.

func _set_train_vis_at_index(tvis:TrainLinkVis,at_position: Vector2)->void:
	if get_child_count()>0:
		var train = get_children()
		var insertIndex :int
		for i in train:
			print("TrainVis at index " +str(i.get_index()))
			print("TrainVis at index position:" + str(i.position.x+old_train_offset))
			print("NewTrainVis position:"+str(at_position.x+new_train_offset))
			if at_position.x+new_train_offset >= i.position.x+old_train_offset:
				insertIndex =i.get_index()+1
				print(insertIndex)
		add_child(tvis)
		move_child(get_child(-1),insertIndex)
	else:
		add_child(tvis)
	settled= false
	pass
