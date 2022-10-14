extends "res://npc_base.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var buffness = 5
export(int) var weakness = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	npc_type = "npc_guard_mad"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in $Area.get_overlapping_bodies():
		if e.name == 'Player':
			Filesys.health -= buffness
		if e.name == 'Bullet':
			health -= weakness
	if health <= 0:
		get_parent().remove_child(self)
	pass
