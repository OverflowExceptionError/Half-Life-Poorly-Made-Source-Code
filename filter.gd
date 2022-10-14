extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var egg = false
export (int) var ScreenWidth = 320
export (int) var ScreenHeight = 240
# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport/Player.egg = egg
	$Viewport.size[0] = ScreenWidth
	$Viewport.size[1] = ScreenHeight
	$Viewport.size_override_stretch = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
