extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var map = 'res://maps/c1a1.tscn'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in get_overlapping_bodies():
		if e.name == 'cart':
			print('kaboom!')
			get_tree().change_scene(map)
	pass
