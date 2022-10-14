extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var teleport_node
onready var real_teleport_node = get_node(teleport_node)
export(NodePath) var player
onready var real_player = get_node(player)
func run_trigger(state):
	real_player.global_transform.origin = real_teleport_node.global_transform.origin
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
