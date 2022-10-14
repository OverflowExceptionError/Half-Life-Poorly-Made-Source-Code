extends "res://camera.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_key_pressed(KEY_C):
		var e = load('res://models/Ignore/prop_aperature_cube.tscn').instance()
		e.transform.origin = transform.origin
		get_parent().get_parent().add_child(e)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
