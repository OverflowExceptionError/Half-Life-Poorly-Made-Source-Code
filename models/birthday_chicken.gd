extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var PlayerPath = '../Player'
export(int) var type = 0
export(int) var direction = 0
var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBody/CollisionShape/Sprite3D.PlayerPath = NodePath('../../../' + str(PlayerPath) + '/Viewport/Player')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
