extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var sitting = true
export(bool) var chase_player = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$sitting.visible = sitting
	$not_sitting.visible = not sitting
	pass # Replace with function body.
var move = null
var velocity = Vector3()
var direction = Vector3()
var _speed = 0
export(int) var speed = 5
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if chase_player:
		look_at(get_parent().get_node(get_parent().player_path).rotation_degrees,Vector3.UP)
		velocity = Vector3(0,0,speed)
		velocity = move_and_slide_with_snap(transform.basis * -velocity,Vector3(0,0,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
