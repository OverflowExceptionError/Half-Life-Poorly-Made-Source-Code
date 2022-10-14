extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		if get_parent().get_node("LineEdit").text != '':
			var success = ProjectSettings.load_resource_pack("res://" + get_parent().get_node("LineEdit").text + ".pck")
			if success:
				# Now one can use the assets as if they had them in the project from the start.
				get_tree().change_scene('res://maps/mm.tscn')
		else:
			var success = ProjectSettings.load_resource_pack("res://default.pck")
			if success:
				# Now one can use the assets as if they had them in the project from the start.
				get_tree().change_scene('res://maps/mm.tscn')
