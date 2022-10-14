extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var entities_gd = ['birthday_chicken','ammo','info_player_start','player_bullet','stair','Ignore/birthday_chicken0','Ignore/info_player_started','Ignore/info_thirdperson_start','Ignore/lighting','Ignore/prop_aperature_button','Ignore/prop_aperature_cube']
var entities = ['birthday_chicken','ammo','info_player_replay','info_player_start','LightSource','npc_chicken','player_bullet','stair','Ignore/birthday_chicken0','Ignore/info_player_started','Ignore/info_thirdperson_start','Ignore/lighting','Ignore/prop_aperature_button','Ignore/prop_aperature_cube','Shapes/Sphere','Shapes/Boxes/box2x2x2','Shapes/Boxes/box2x2x6','Shapes/Boxes/box2x6x6','Shapes/Boxes/box6x2x2','Shapes/Boxes/box6x2x6','Shapes/Boxes/box6x6x2','Shapes/Boxes/box6x6x6','Shapes/Stairs/4 stairs','/npc_barney_chase','/npc_monster']
func _on_Button_pressed():
	var command = $LineEdit.text.split(' ')
	if command[0] == 'quit' or command[0] == 'exit':
		get_tree().quit()
	elif command[0] == 'return':
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_parent().remove_child(self)
	elif command[0] == 'map':
		get_tree().change_scene(command[1])
	elif command[0] == 'cl_mouse_visible':
		if command[1] == '1':
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif command[1] == '0':
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif command[0] == 'obj_create':
		var object = load(command[1]).instance()
		object.transform.origin = get_parent().get_node('ViewportContainer/Viewport/Player').transform.origin
		get_parent().add_child(object)
	elif command[0] == 'mdl_create':
		var object = MeshInstance.new()
		object.transform.origin = get_parent().get_node('ViewportContainer/Viewport/Player').transform.origin
		object.mesh = load(command[1])
		get_parent().add_child(object)
	elif command[0] == 'list_godsrc_ents':
		print('GodSrc Entity List')
		for e in entities:
			print(e)
		print(str(len(entities)) + ' entities total.')
	elif command[0] == 'legacy_gdoom_list':
		print('GDoom Entity List')
		for e in entities_gd:
			print(e)
		print(str(len(entities_gd)) + ' entities total.')
	pass # Replace with function body.
