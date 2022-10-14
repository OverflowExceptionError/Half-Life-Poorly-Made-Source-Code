extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var player_old_pos = Vector3()
var player_old_scale = Vector3()
var player = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		player.scale = get_parent().scale
		player.walk_speed = 1
		player.sprint_speed = 2
		player.jump_height = 1
	for e in get_overlapping_bodies():
		if e.name == "Player":
			player = e
			player_old_pos = player.global_transform.origin
			player_old_scale = Vector3(1,1,1)
			e.scale = get_parent().scale
			e.walk_speed = 1
			e.sprint_speed = 2
			e.jump_height = 1
			e.global_transform.origin = get_parent().get_node('PlayerSpawn').global_transform.origin
			$CollisionShape.disabled = true
			pass
	pass
