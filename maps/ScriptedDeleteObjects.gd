extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var object_1
export(NodePath) var object_2
var ran = false

func run_trigger(state):
	if not ran:
		get_node(object_1).get_parent().remove_child(get_node(object_1))
		get_node(object_2).get_parent().remove_child(get_node(object_2))
		ran = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
