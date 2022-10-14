extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var move = null
var velocity = Vector3()
var direction = Vector3()
var _speed = 0
export(int) var speed = 5
var health = 1
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	velocity = Vector3(0,0,speed)
	velocity = move_and_slide_with_snap(transform.basis * -velocity,Vector3(0,0,0))
	print(velocity)
	print(transform.basis)
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for e in $Area.get_overlapping_bodies():
		if get_parent() != null:
			if e != self and e != get_parent().get_node('Player') and e.get_class() == 'RigidBody':
				e.get_parent().remove_child(e)
				self.set_script(null)
				get_parent().remove_child(self)
			elif e != self and e != get_parent().get_node('Player') and e.get_class() == 'KinematicBody':
				e.health -= 1
				self.set_script(null)
				get_parent().remove_child(self)
			elif e != self:
				self.set_script(null)
				get_parent().remove_child(self)
	pass
