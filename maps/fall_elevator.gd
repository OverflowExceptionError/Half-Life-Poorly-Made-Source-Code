extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var elevator_path = '../ent_moving_platform'
onready var elevator = get_node(elevator_path)
var falling_elevator = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in get_overlapping_bodies():
		if e.name == 'Player':
			if not falling_elevator:
				elevator.get_node('ent_door/side1/ent_glass').health = 0
				elevator.get_node('ent_door/side2/ent_glass2').health = 0
			falling_elevator = true
			
		pass
	if falling_elevator:
		elevator.translation -= Vector3(0,0.1,0)
	pass
