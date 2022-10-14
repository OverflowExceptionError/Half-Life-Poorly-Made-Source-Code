extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var player_path = 'ViewportContainer/Viewport/Player'
export(NodePath) var chapter_title_path
export(bool) var is_map_flipped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.level_trans_dest != "default":
		if not is_map_flipped:
			get_node(player_path).transform = get_node(Globals.level_trans_dest).transform
			get_node(player_path).rotation_degrees = get_node(Globals.level_trans_dest).rotation_degrees
		else:
			get_node(player_path).transform = $Spatial.get_node(Globals.level_trans_dest).transform
			get_node(player_path).rotation_degrees = $Spatial.get_node(Globals.level_trans_dest).rotation_degrees
	else:
		if chapter_title_path != '':
			get_node(chapter_title_path)._play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Filesys.health <= 0 and Filesys.health > -100:
		var player_transform = get_node(player_path).global_transform.origin
		var player_rotation = get_node(player_path).rotation
		
		get_node(player_path).get_parent().remove_child(get_node(player_path))
		var lol = Camera.new()
		lol.global_transform.origin = player_transform
		lol.rotation = player_rotation
		lol.current = true
		add_child(lol)
	pass
