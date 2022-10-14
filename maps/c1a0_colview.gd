extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vi_mat = SpatialMaterial.new()
func do_me(o):
	for e in o.get_children():
		vi_mat.albedo_color = Color8(255,0,0)
		print(vi_mat.albedo_color)
		if e.get_class() == 'CSGBox':
			if e.use_collision:
				e.material = vi_mat
			else:
				pass
		do_me(e)
# Called when the node enters the scene tree for the first time.
func _ready():
	for e in get_children():
		vi_mat.albedo_color = Color8(255,0,0)
		print(vi_mat.albedo_color)
		if e.get_class() == 'CSGBox':
			if e.use_collision:
				e.material = vi_mat
			else:
				pass
		do_me(e)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
