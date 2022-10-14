extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var e = [0.118,0.114,0]
var flg_isBullet = false
var fire = false
var start_firing = false
var n = Spatial.new()
var f = 0
onready var bodies = [get_node('RayCast'),get_node('RayCast2'),get_node('RayCast3'),get_node('RayCast4'),get_node('RayCast5')]
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().type == 1:
		flg_isBullet = true
	if flg_isBullet:
		$CollisionShape/Sprite3D.material = load('res://materials/bullet.tres')
		$CollisionShape.shape = BoxShape.new()
		$CollisionShape.shape.extents = Vector3(e[0],e[1],e[2])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	f += 1
	bodies = [get_node('RayCast'),get_node('RayCast2'),get_node('RayCast3'),get_node('RayCast4'),get_node('RayCast5')]
	self.rotation_degrees = Vector3(0,0,0)
	if flg_isBullet:
		for cast in bodies:
			if cast.get_collider() != null:
				if cast.get_collider().name == 'Player':
					Filesys.health -= 1
		if get_parent().direction == 0:
			get_parent().transform.origin[0] += 0.1
		if get_parent().direction == 1:
			get_parent().transform.origin[0] -= 0.1
		if get_parent().direction == 2:
			get_parent().transform.origin[2] += 0.1
		if get_parent().direction == 3:
			get_parent().transform.origin[2] -= 0.1
	else:
		for cast in bodies:
			if cast.get_collider() != null:
				if cast.get_collider().name == 'Player':
					start_firing = true
		if get_parent().health < 1:
			get_parent().remove_child(self)
	if start_firing:
		if f > 100:
			n = load('res://models/birthday_chicken.tscn').instance()
			n.type = 1
			n.direction = 0
			get_parent().get_parent().add_child(n)
			f = 0
	pass
