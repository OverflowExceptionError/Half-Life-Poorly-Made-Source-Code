extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var peer = NetworkedMultiplayerENet.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	peer.create_server(8080, 127)
	get_tree().network_peer = peer
	get_tree().network_peer = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var players = {}
var default_player_data = {'name':'MinjBag'}
func _player_connected(id):
	print('aa player connected ' + str(id))
	players.id = default_player_data
func _player_disconnected(id):
	print('aww player disconnected '+ str(id))
	players.erase(id)
remote func retrive_map():
	return get_tree().root.get_node('mp_level')
remote func set_player_name(player_name):
	#var id_th = SceneTree.get_rpc_sender_id()
	pass
var textin = []
var my_id = 1

func _on_Button_pressed():
	textin = $LineEdit.text.split('\n')
	if $LineEdit.text == '':
		pass
	elif textin[0] == 'sv_hev':
		if textin[1] == '1':
			get_parent().sv_hev = true
		elif textin[1] == '0':
			get_parent().sv_hev = false
	elif textin[0] == 'server_connect':
		peer.create_client(textin[1],int(textin[2]))
		get_tree().network_peer = peer
		get_tree().root.add_child(rpc_id(1,'retrive_map'))
		get_parent().get_parent().get_parent().get_parent().visible = false
		rpc_id(1,'set_player_name',textin[3])
	elif textin[0] == 'server_create':
		get_tree().network_peer = peer
		get_tree().connect("network_peer_connected", self, "_player_connected")
		get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
		pass
	pass # Replace with function body.
