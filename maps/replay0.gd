extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(bool) var is_play = false
export(bool) var is_play_no_replay = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		var level = load('res://maps/' + get_parent().get_node("LineEdit").text + '.tscn').instance()
		if get_parent().get_node('LineEdit2').text != '':
			Globals.replay_name = get_parent().get_node('LineEdit2').text
		else:
			Globals.replay_name = "session_data"
		var replay_player = load('res://models/info_player_replay.tscn').instance()
		level.set_script(null)
		get_parent().add_child(level)
		level.get_node('ViewportContainer/Viewport').remove_child(level.get_node('ViewportContainer/Viewport/Player'))
		if is_play:
			replay_player.remove_child(replay_player.get_node('Head'))
		if not is_play_no_replay:
			level.get_node('ViewportContainer/Viewport').add_child(replay_player)
		if is_play:
			var player = Camera.new()
			player.set_script(load('res://camera.gd'))
			player.current = true
			if is_play_no_replay:
				player.name = "FreeCam"
				var fake_player = Spatial.new()
				fake_player.name = 'Player'
				level.get_node('ViewportContainer/Viewport').add_child(fake_player)
			level.get_node('ViewportContainer/Viewport').add_child(player)
		disabled = true
		get_parent().get_node('LineEdit').visible = false
		get_parent().get_node('LineEdit2').visible = false
		visible = false
		get_parent().get_node("Label").visible = false
	pass
