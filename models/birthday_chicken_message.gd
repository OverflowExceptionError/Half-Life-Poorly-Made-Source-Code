extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var player_path = '../Player'
export(int) var type = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print('GDoom Warning: Entity birthday_chicken is deprecated in favor of npc_chicken!')
	print('But instead of being a jerk and not doing anything, we wil redirect this object to npc_chicken.')
	var ll = load('res://models/npc_chicken.tscn').instance()
	ll.transform.origin = self.transform.origin
	ll.PlayerPath = player_path
	ll.type = type
	get_parent().call_deferred('add_child', ll)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
