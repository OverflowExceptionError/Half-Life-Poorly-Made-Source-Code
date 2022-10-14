extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(bool) var capped = false #For boring people!
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in $Area.get_overlapping_bodies():
		if e.name == 'Player':
			if Filesys.ammo < 95 and capped:
				Filesys.ammo += 15
			elif not capped:
				Filesys.ammo += 15
			get_parent().remove_child(self)
	pass
