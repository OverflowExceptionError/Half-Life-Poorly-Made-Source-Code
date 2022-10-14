extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var PlayerPath = '../../../../ViewportContainer/Viewport/Player'
onready var head = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# print(head)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	head = get_node(PlayerPath)
	if head == null:
		head = get_parent()
	# print(head.rotation)
	if get_parent().get_class() != "CollisionShape":
		get_parent().rotation[1] = head.rotation[1]
		get_parent().rotation[2] = 0
		get_parent().rotation[0] = 0
	if get_parent().get_class() == "CollisionShape":
		get_parent().get_parent().rotation[1] = head.rotation[1]
		get_parent().get_parent().rotation[2] = 0
		get_parent().get_parent().rotation[0] = 0
