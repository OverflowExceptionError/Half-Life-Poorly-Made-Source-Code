extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var open_door_anim = false
var close_door_anim = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open_door_anim and $side1.transform.origin.x > -1 and $side2.transform.origin.x < 1:
		$side1.transform.origin.x -= 0.01
		$side2.transform.origin.x += 0.01
	if close_door_anim and $side1.transform.origin.x < 0 and $side2.transform.origin.x > 0:
		$side1.transform.origin.x += 0.01
		$side2.transform.origin.x -= 0.01
	print(open_door_anim)
	print(close_door_anim)
	pass
func run_trigger(state):
	if state == 0:
		open_door_anim = true
		close_door_anim = false
	if state == 1:
		close_door_anim = true
		open_door_anim = false

func _on_Area_body_entered(body):
	if body.name == 'Player':
		open_door_anim = true
		close_door_anim = false
	pass # Replace with function body.


func _on_Area_body_exited(body):
	if body.name == 'Player':
		close_door_anim = true
		open_door_anim = false
	pass # Replace with function body.
