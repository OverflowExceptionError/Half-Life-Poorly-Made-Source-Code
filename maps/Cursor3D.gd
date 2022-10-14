extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouse_axis = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_axis = event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Vector2toVector3(vector: Vector2, position_z=0):
	return Vector3(vector.x,vector.y,position_z)
func _process(delta):
	transform.origin = Vector2toVector3(mouse_axis)
	pass
