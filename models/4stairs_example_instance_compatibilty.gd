extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(bool) var isSlope = true
# Called when the node enters the scene tree for the first time.
func _ready():
	for stair in get_children():
		stair.isSlope = isSlope
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
