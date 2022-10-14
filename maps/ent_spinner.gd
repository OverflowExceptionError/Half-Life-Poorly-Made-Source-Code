extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flip = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees.y += 1
	for e in get_children():
		if e.translation.y < 1 and e.translation.y > -1 and not flip:
			e.translation.y += 0.01
		else:
			flip = true
			e.translation.y -= 0.01
			if e.translation.y < 1 and e.translation.y > -1 and flip:
				e.translation.y -= 0.01
			else:
				flip = false
		if e.translation.y < 15 or e.translation.y > -15:
			e.translation.y = 0
		
	pass
