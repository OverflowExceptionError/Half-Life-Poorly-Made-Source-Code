extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Vector2) var move_axis = Vector2(1,0)
export (Vector2) var mouse_axis = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		get_parent().move_axis = move_axis
		get_parent().mouse_axis = mouse_axis
		get_parent().camera_rotation()
	pass
