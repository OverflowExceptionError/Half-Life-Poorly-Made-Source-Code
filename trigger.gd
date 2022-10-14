extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var object_path
var object = null
var state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if object_path != NodePath():
		object = get_node(object_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in get_overlapping_bodies():
		if e.name == 'Player':
			object.run_trigger(state)
	pass
