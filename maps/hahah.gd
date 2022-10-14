extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_debug_generate_wireframes(true)
	get_viewport().debug_draw= Viewport.DEBUG_DRAW_WIREFRAME
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
