extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var head = $Head
onready var cam = $Head/Camera
var stringy = ''
var delp = 0
var egg = false
var amount = 0
var max_usable_amount = 10000
var increment = 0
var lils = []
var lil = null
func fire_bullet():
	#bullet = load('res://models/player_bullet.tscn').instance()
	#bullet.transform.origin = self.transform.origin + cam.transform.origin
	#bullet.rotation = self.rotation
	#get_parent().add_child(bullet)
	for e in cam.get_children():
		lil = CSGBox.new()
		lil.width = 0.1
		lil.height = 0.1
		lil.depth = 0.1
		if e.get_collider() != null:
			if e.get_collider().get_class() != 'RigidBody':
				lil.material = e.get_collider().material
		if amount < max_usable_amount:
			get_parent().call_deferred("add_child",lil)
			amount += 1
			lil.transform.origin = e.get_collision_point()
		lils.append(lil)
	if amount > max_usable_amount - 1:
		for e in range(0,max_usable_amount):
			if e < len(lils):
				if get_parent().has_node(lils[e].name):
					get_parent().remove_child(lils[e])
					lils.remove(e)
		amount -= max_usable_amount
	increment = 0
	#while len(get_parent().get_children()) > max_usable_amount:
	#	if get_parent().get_children()[increment].get_class() == 'CSGBox':
	#		get_parent().remove_child(get_parent().get_children()[increment])
	increment = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	fire_bullet()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
