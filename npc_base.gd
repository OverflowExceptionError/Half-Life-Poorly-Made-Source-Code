extends KinematicBody
#Built-in type npc_base
export(NodePath) var player_path
export(NodePath) var navigation_path
var velocity = Vector3()
var npc_type = "npc_base"
var nodes = []
export(int) var speed = 2
export(bool) var hud_enabled = false
export(int) var health = 100
var model_name = 'prototype_security_guard'
func _ready():
	if $Label != null:
		$Label.visible = hud_enabled
	pass
func _physics_process(delta):
	var fart = get_node(navigation_path).get_simple_path(self.transform.origin, get_node(player_path).transform.origin, false)
	for e in fart:
		#var lil = CSGBox.new()
		#lil.width = 1
		#lil.height = 1
		#lil.depth = 1
		#lil.transform.origin = e
		#get_parent().add_child(lil)
		#nodes.append(lil)
		look_at(e,Vector3.UP)
		velocity = Vector3(0,10,speed)
		velocity = move_and_slide_with_snap(transform.basis * -velocity,Vector3(0,0,0))
		if $prototype_security_guard.mesh == load('res://models/' + model_name + '_runpose2.obj'):
			yield(get_tree().create_timer(0.3), "timeout")
			$prototype_security_guard.mesh = load('res://models/' + model_name + '_runpose1.obj')
		else:
			yield(get_tree().create_timer(0.3), "timeout")
			$prototype_security_guard.mesh = load('res://models/' + model_name + '_runpose2.obj')
	for e in nodes:
		if e.get_parent() != null and e != null:
			e.get_parent().remove_child(e)
			nodes.erase(e)
	if health <= 0:
		$CollisionShape.disabled = true
		$Label.visible = false
	if len(fart) == 0:
		$prototype_security_guard.mesh = load('res://models/' + model_name + '.obj')
	if $Label != null:
		$Label.text = npc_type + " (" + name + ") with " + str(health) + " health"
