extends HBoxContainer

#word_vis_holder.gds

@export var trainVis:TextureRect

var newWordVisScene =preload("res://Scenes/WordVisual.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is WordVis and trainVis._get_train_vis_train_link()._get_acceptable_word_type() == data._get_word_type():
		return true
	else:
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	add_child(data._make_copy_of_self())
	trainVis._get_train_vis_train_link()._update_train_link_word(get_child(0)._get_word_vis_word())
	data.queue_free()

func _is_empty()->bool:
	if get_child_count()>0:
		return false
	else:
		return true
