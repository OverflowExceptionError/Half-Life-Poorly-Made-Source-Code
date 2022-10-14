extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var physics_check = get_node("prop_aperature_cube").get_colliding_bodies()
var player_origin = Vector3(0,0,0)
var box_origin = self.transform.origin
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	physics_check = get_node("prop_aperature_cube").get_colliding_bodies()
	if physics_check.size() > 0:
		if physics_check[0].name == "ButtonBT":
			print("This is the default button interaction code - To change the button interaction, open scripts/button_interaction.gd")
	#print(physics_check)
	if Input.is_key_pressed(KEY_1):
		get_node("../../CubeContainer").transform.origin = get_node("../../CubeContainer").transform.origin + Vector3(-1,0,0)
	if Input.is_key_pressed(KEY_2):
		get_node("../../CubeContainer").transform.origin = get_node("../../CubeContainer").transform.origin + Vector3(-0.5,0,0)
	if Input.is_key_pressed(KEY_3):
		get_node("../../CubeContainer").transform.origin = get_node("../../CubeContainer").transform.origin + Vector3(0,0,-1)
	if Input.is_key_pressed(KEY_4):
		get_node("../../CubeContainer").transform.origin = get_node("../../CubeContainer").transform.origin + Vector3(0,0,-0.5)
	if Input.is_key_pressed(KEY_5):
		get_node("../../CubeContainer").transform.origin = get_node("../../CubeContainer").transform.origin + Vector3(0,10,0)
	if Input.is_key_pressed(KEY_6):
		get_node("../../Player").transform.origin = get_node("../../Player").transform.origin + Vector3(0,1,0)
	if Input.is_key_pressed(KEY_M):
		get_node("../Player").transform.origin = get_node("../Player").transform.origin + Vector3(0,1,0)
	if Input.is_key_pressed(KEY_7):
		get_node("../../Player").transform.origin = get_node("../../Player").transform.origin + Vector3(0,-0.5,0)
	if Input.is_key_pressed(KEY_8):
		get_node("../../Player").transform.origin = self.transform.origin
	if Input.is_key_pressed(KEY_9):
		self.transform.origin = get_node("../../Player").transform.origin
	if Input.is_key_pressed(KEY_0):
		player_origin = get_node("../../Player").transform.origin
		get_node("../../Player").transform.origin = box_origin
		self.transform.origin = player_origin
	pass
