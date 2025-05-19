extends TextureRect

@export var trainBay: VBoxContainer

var greenlight = preload("res://PNGs/Greenlight.png")
var redlight = preload("res://PNGs/Redlight.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_train_bay_child_order_changed() -> void:
	print("Train Vis Changed")
	if not(trainBay._is_empty()) and not(trainBay._get_train_vis_in_bay().wordHolder._is_empty()):
		set_texture(greenlight)
	else:
		set_texture(redlight)
	pass # Replace with function body.
