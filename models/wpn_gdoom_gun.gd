extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == 'Player':
		body.bullet_type = 'player'
		body.spawn_with_suit = true
		print('Picked up GDoom Weapon')
		print('HEV VO: Aquirred Memory Enducing Apperatus')
		get_parent().remove_child(self)
	pass # Replace with function body.
