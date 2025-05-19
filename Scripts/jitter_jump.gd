extends Sprite2D

@export var max_pitch_angle:float = 3.0
@export var rot_speed:float =3.0
@export var phase_nought:float
@export var y_nought:float
@export var max_jump_height: float
@export var x_nought: float
var t=0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var delta_deg = 20
	t+=delta*rot_speed
	#rotation_degrees = max_pitch_angle*cos(t*rot_speed+phase_nought)
	#print("Rot:"+str(rotation))
	position.y = -max_jump_height*(1/PI*.5*sin(t*rot_speed-x_nought)-2/PI*(.25*cos((2*t*rot_speed-x_nought))))+ y_nought 
	#-abs(max_jump_height*sin(t*rot_speed)+phase_nought)+ y_nought
	#print("Rot in Deg"+str(rotation_degrees))
	
	pass
