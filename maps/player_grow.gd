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
var backup_player = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_parent().get_node("Area").player
	player_old_pos = get_parent().get_node("Area").player_old_pos
	player_old_scale = get_parent().get_node("Area").player_old_scale
	if backup_player != null:
		backup_player.scale = player_old_scale
		backup_player.walk_speed = 10
		backup_player.sprint_speed = 16
		backup_player.jump_height = 10
	for e in get_overlapping_bodies():
		if e.name == "Player":
			e.global_transform.origin = player_old_pos
			e.scale = player_old_scale
			e.walk_speed = 10
			e.sprint_speed = 16
			e.jump_height = 10
			$CollisionShape.disabled = true
			backup_player = e
			get_parent().get_node("Area").player = null
			pass
	pass
