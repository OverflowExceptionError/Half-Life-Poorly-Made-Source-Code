extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var red_flip = false
var red = 255
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.albedo_color = Color8(red,0,0)
	yield(get_tree().create_timer(0.1), "timeout")
	print(red)
	if red > 0:
		if not red_flip:
			red -= 1
		else:
			if red < 255:
				red += 1
			else:
				red_flip = not red_flip
	else:
		red_flip = not red_flip
	if red_flip:
		if red < 255:
			red += 1
		else:
			red_flip = not red_flip
	pass
