extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var scene = "res://maps/playtest.tscn"
export(NodePath) var replay_name_path = ''
export(bool) var is_gms = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if pressed:
		if is_gms:
			Globals.gms = get_parent().get_node("TextEdit").text
		get_tree().change_scene(scene)
	if replay_name_path != '':
		if get_node(replay_name_path).text != '':
			Globals.replay_name = get_node(replay_name_path).text
		else:
			Globals.replay_name = "session_data"
	pass
