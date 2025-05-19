extends TextureRect

class_name StampVisual

#stamp_visual.gd

@export var stampLabel: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _set_stamp_texture(inputTexture:Texture2D)->void:
	self.texture =inputTexture
	pass

func _set_stamp_label(inputString:String)->void:
	stampLabel.set_text(inputString)
	pass
