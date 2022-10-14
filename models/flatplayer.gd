extends "res://scripts/ent_player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if capture_replay:
		player_pos_data += str(transform.origin.x) + ' ' + str(transform.origin.y) + ' ' + str(transform.origin.z) + ' ' + str(rotation_degrees.x) + ' ' + str(rotation_degrees.y) + ' ' + str(rotation_degrees.z) + '\n'
		#print(player_pos_data)
		Filesys.write_file('user://' + Globals.replay_name + '.txt',player_pos_data)
		player_pos_data = Filesys.load_file('user://' + Globals.replay_name + '.txt')
	delp += 1
	if not freecam:
		move_axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		# else:
		# 	mouse_axis.y = Input.get_action_strength("strafe_right") - Input.get_action_strength("strafe_left")
	if Input.is_key_pressed(KEY_0):
		get_parent().size.x = 1024*16
		get_parent().size.y = 768*16
	if Input.is_key_pressed(KEY_1):
		get_parent().size.x = 1024*6
		get_parent().size.y = 768*6
	if Input.is_key_pressed(KEY_2):
		get_parent().size.x = 1024*4
		get_parent().size.y = 768*4
	if Input.is_key_pressed(KEY_3):
		get_parent().size.x = 1024*2
		get_parent().size.y = 768*2
	if Input.is_key_pressed(KEY_4):
		get_parent().size.x = 1024
		get_parent().size.y = 768
	if Input.is_key_pressed(KEY_5):
		get_parent().size.x = 640
		get_parent().size.y = 480
		#$Label.rect_scale = Vector2(10,10)
		#$Label.rect_position = Vector2(0,480 - $Label.rect_size.y)
	if Input.is_key_pressed(KEY_6):
		get_parent().size.x = 320
		get_parent().size.y = 240
		#$Label.rect_scale = Vector2(1,1)
		#$Label.rect_position = Vector2(0,240 - $Label.rect_size.y)
	if Input.is_key_pressed(KEY_7):
		get_parent().size.x = 160
		get_parent().size.y = 120
		#$Label.rect_scale = Vector2(0.01,0.01)
		#$Label.rect_position = Vector2(0,120 - $Label.rect_size.y)
	if Input.is_key_pressed(KEY_8):
		get_parent().size.x = 160/2
		get_parent().size.y = 120/2
		#$Label.rect_position = Vector2(0,(120/2) - $Label.rect_size.y)
		#$Label.rect_scale = Vector2(0.001,0.001)
	if Input.is_key_pressed(KEY_TAB) and delp > 30:
		#magically freecam
		if freecamd.get_script() != load('res://camera.gd'):
			freecamd.set_script(load('res://camera.gd'))
			freecamd.current = true
			$Label.text = "FREECAM"
			get_parent().add_child(freecamd)
			freecam = true
			freecamd.transform.origin = freecam_old_position
			freecamd.rotation = freecam_old_rotation
		else:
			freecamd.set_script(null)
			#cam.transform.origin = Vector3()
			#cam.rotation = Vector3()
			freecam_old_position = freecamd.transform.origin
			freecam_old_rotation = freecamd.rotation
			get_parent().remove_child(freecamd)
			$Label.text = "HEALTH"
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			freecam = false
		delp = 0
	if Input.is_key_pressed(KEY_9) and delp > 30:
		if freecam:
			freecamd.set_script(null)
			freecam = null
		else:
			freecamd.set_script(load("res://camera.gd"))
			freecam = true
		delp = 0
	if Input.is_key_pressed(KEY_E):
		if _is_picking_up_physbox != true:
			_is_picking_up_physbox = true
		else:
			_is_picking_up_physbox = false
	if Input.is_action_just_pressed("move_jump") and egg and not freecam:
		_is_jumping_input = true
	if Input.is_key_pressed(KEY_I) and delp > 30:
		stringy += 'i'
		delp = 0
	if Input.is_key_pressed(KEY_T) and delp > 30:
		stringy += 't'
		delp = 0
	if Input.is_key_pressed(KEY_L) and delp > 30:
		stringy += 'l'
		delp = 0
	if Input.is_key_pressed(KEY_P) and delp > 30:
		stringy += 'p'
		delp = 0
	if Input.is_key_pressed(KEY_N) and delp > 30:
		stringy += 'n'
		delp = 0
	if Input.is_key_pressed(KEY_R) and delp > 30:
		stringy += 'r'
		delp = 0
	if Input.is_key_pressed(KEY_M) and delp > 30:
		stringy += 'm'
		delp = 0
	if Input.is_key_pressed(KEY_ENTER) and delp > 30:
		if stringy == 'itlp':
			# do teleporty stuff
			egg = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			transform.origin = Vector3(15.701,-4.007,-0.252)
			stringy = ''
			pass
		elif stringy == 'irpn':
			print('10x AMMO CHEAT CODE')
			Filesys.ammo = Filesys.ammo*10
		elif stringy == 'irpm':
			print('10x HEALTH CHEAT CODE')
			Filesys.health = Filesys.health*10
		elif stringy == 'imnr':
			get_parent().get_parent().get_parent().add_child(load('res://console.tscn').instance())
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif stringy == 'i':
			print('INFINITYx AMMO & HEALTH CHEAT CODE')
			Filesys.ammo = 4294967295
			Filesys.health = 4294967295
			$Label2.set_script(null)
			$Label4.set_script(null)
			$Label2.text = "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
			$Label4.text = "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
		elif stringy == 'icrsh':
			var caa = Label.new()
			caa.text = "GodSrc crashed while trying to process function player.stop()\nFile: player.gs\nLine(s) associated:\n\tif keyboard.cheat_code == \"icrsh\":\n\t\tcrash_on_failure_exec(\"player.stop\")"
			get_parent().add_child(caa)
			get_parent().remove_child(self)
		elif stringy == 'inrm':
			# do teleporty stuff
			if egg:
				egg = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				egg = true
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			stringy = ''
			pass
		elif stringy == 'int':
			# do teleporty stuff
			print('I n t i g e r')
			print('NOCLIP ENABLED')
			for e in get_parent().get_parent().get_parent().get_children():
				if e != excludes[0] and e != excludes[1] and e.get_class() == 'CSGBox':
					e.use_collision = false
				else:
					if e.get_class() == 'CSGBox':
						e.use_collision = true
					elif e.get_class() == 'Spatial' and e.name == 'SpatialBox':
						for f in e.get_children():
							if f != excludes[2] and f != excludes[3] and f.get_class() == 'CSGBox':
								f.use_collision = false
			stringy = ''
			pass

		else:
			print('You typed ' + stringy)
			stringy = ''
			print('Cleared password')
		delp = 0
	if Input.is_mouse_button_pressed(1) and delp > 40:
		if spawn_with_suit and Filesys.ammo > 0:
			fire_bullet()
			Filesys.ammo -= 1
		delp = 0
	if Input.is_action_pressed("move_sprint"):
		_is_sprinting_input = true
	if Input.is_key_pressed(KEY_SHIFT):
		self.transform[1][1] = 0.3
	elif Input.is_key_pressed(KEY_CAPSLOCK):
		self.transform[1][1] = 0.01
		mouse_sensitivity = 3.0
	elif Input.is_key_pressed(KEY_F1):
		self.transform[1][1] = 0.001
		mouse_sensitivity = 3.0
	else:
		self.transform[1][1] = 1
		mouse_sensitivity = 8.0
	camera_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
