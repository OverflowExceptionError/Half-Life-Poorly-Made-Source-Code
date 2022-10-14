extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var model_name = 'prototype_security_guard'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mesh == load('res://models/' + model_name + '_runpose2.obj'):
		yield(get_tree().create_timer(0.3), "timeout")
		mesh = load('res://models/' + model_name + '_runpose1.obj')
	else:
		yield(get_tree().create_timer(0.3), "timeout")
		mesh = load('res://models/' + model_name + '_runpose2.obj')
	pass
