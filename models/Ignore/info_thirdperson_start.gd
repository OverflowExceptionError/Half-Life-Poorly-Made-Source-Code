extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var lil = load('res://models/info_player_start.tscn').instance()
	lil.egg = true
	get_parent().call_deferred("add_child",lil)
	get_parent().remove_child(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
