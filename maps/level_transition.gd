extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var level_path = "res://maps/c1a0a.tscn"
export(String) var destination_path = "level_player_aaa"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in get_overlapping_bodies():
		if e.name == 'Player':
			Globals.level_trans_dest = destination_path
			get_tree().change_scene(level_path)
	pass
