extends KinematicBody

###################-VARIABLES-####################

# Camera
export(float) var mouse_sensitivity = 1.0
export(NodePath) var head_path = "Head"
export(NodePath) var cam_path = "Head/Camera"
export(float) var FOV = 80.0
var mouse_axis := Vector2()
onready var head: Spatial = get_node(head_path)
onready var cam: Camera = get_node(cam_path)
# Move
var velocity := Vector3()
var direction := Vector3()
var move_axis := Vector2()
var snap := Vector3()
var sprint_enabled := true
var sprinting := false
# Walk
const FLOOR_MAX_ANGLE: float = deg2rad(46.0)
export(float) var gravity = 30.0
export(int) var walk_speed = 10
export(int) var sprint_speed = 16
export(int) var acceleration = 8
export(int) var deacceleration = 10
export(float, 0.0, 1.0, 0.05) var air_control = 0.3
export(int) var jump_height = 10
var _speed: int
var _is_sprinting_input := false
var _is_jumping_input := false
var _is_picking_up_physbox := false
var bullet = Spatial.new()
onready var excludes = [get_node('../box'),get_node('../box2'),get_node('../SpatialBox/box20'),get_node('../SpatialBox/box21')]
##################################################
var lil = CSGBox.new()
# Called when the node enters the scene tree
var stringy = ''
var delp = 0
export(bool) var capture_replay = true
var egg = true
var amount = 0
var max_usable_amount = 10000
var increment = 0
var lils = []
var player_pos_data = """"""
onready var freecamd = Camera.new()
export(bool) var spawn_with_suit = false
var sv_hev = spawn_with_suit
func _ready() -> void:
	cam.fov = FOV
	if egg:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(excludes)
var bullet_type = 'player'
func fire_bullet():
	bullet = load('res://models/' + bullet_type + '_bullet.tscn').instance()
	bullet.transform.origin = self.transform.origin + cam.transform.origin
	bullet.rotation = self.rotation
	get_parent().add_child(bullet)
func fire_raycast():
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
# egg = false: Old DOOM style movement physics
# egg = true: Standard Smorce 2 movement physics
# Called every frame. 'delta' is the elapsed time since the previous frame
var freecam = false
var freecam_old_position = Vector3()
var freecam_old_rotation = Vector3()
func _process(_delta: float) -> void:
	$MeshInstance.visible = false
	if capture_replay:
		if player_pos_data != null:
			player_pos_data += str(transform.origin.x) + ' ' + str(transform.origin.y) + ' ' + str(transform.origin.z) + ' ' + str(rotation_degrees.x) + ' ' + str(rotation_degrees.y) + ' ' + str(rotation_degrees.z) + '\n'
		#print(player_pos_data)
		Filesys.write_file('user://' + Globals.replay_name + '.txt',player_pos_data)
		player_pos_data = Filesys.load_file('user://' + Globals.replay_name + '.txt')
	delp += 1
	if not freecam:
		move_axis.x = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
		if not egg:
			mouse_axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			move_axis.y = Input.get_action_strength("strafe_right") - Input.get_action_strength("strafe_left")
		else:
			move_axis.y = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			mouse_axis.y = 0
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
		fire_raycast()
		delp = 0
	if Input.is_mouse_button_pressed(1) and delp > 40:
		if spawn_with_suit and Filesys.ammo > 0:
			fire_bullet()
			Filesys.ammo -= 1
		delp = 0
	if Input.is_key_pressed(KEY_F2) and delp > 40:
		var lols = load('res://models/Ignore/prop_aperature_cube.tscn').instance()
		lols.global_transform = self.global_transform
		get_parent().add_child(lols)
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

# Called every physics tick. 'delta' is constant
func _physics_process(delta: float) -> void:
	walk(delta)


# Called when there is an input event
func _input(event: InputEvent) -> void:
	if event is InputEventKey and not freecam:
		camera_rotation()
	if event is InputEventMouseMotion and not freecam:
		if egg:
			mouse_axis = event.relative
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			camera_rotation()


func walk(delta: float) -> void:
	direction_input()
	
	if is_on_floor():
		snap = -get_floor_normal() - get_floor_velocity() * delta
		
		# Workaround for sliding down after jump on slope
		if velocity.y < 0:
			velocity.y = 0
		
		jump()
	else:
		# Workaround for 'vertical bump' when going off platform
		if snap != Vector3.ZERO && velocity.y != 0:
			velocity.y = 0
		
		snap = Vector3.ZERO
		
		velocity.y -= gravity * delta
	
	sprint(delta)
	
	accelerate(delta)
	
	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, FLOOR_MAX_ANGLE)
	_is_jumping_input = false
	_is_sprinting_input = false


func camera_rotation() -> void:
	if mouse_axis.length() > 0:
		var horizontal: float = 0
		if not egg:
			horizontal = -mouse_axis.x * (mouse_sensitivity / 2)
		else:
			horizontal = -mouse_axis.x * (mouse_sensitivity / 100)
		var vertical: float = -mouse_axis.y * (mouse_sensitivity / 100)
		
		mouse_axis = Vector2()
		
		rotate_y(deg2rad(horizontal))
		head.rotate_x(deg2rad(vertical))
		
		# Clamp mouse rotation
		var temp_rot: Vector3 = head.rotation_degrees
		temp_rot.x = clamp(temp_rot.x, -90, 90)
		head.rotation_degrees = temp_rot


func direction_input() -> void:
	direction = Vector3()
	var aim: Basis = get_global_transform().basis
	if move_axis.x >= 0.5:
		direction -= aim.z
	if move_axis.x <= -0.5:
		direction += aim.z
	if move_axis.y <= -0.5:
		direction -= aim.x
	if move_axis.y >= 0.5:
		direction += aim.x
	direction.y = 0
	direction = direction.normalized()


func accelerate(delta: float) -> void:
	# Where would the player go
	var _temp_vel: Vector3 = velocity
	var _temp_accel: float
	var _target: Vector3 = direction * _speed
	
	_temp_vel.y = 0
	if direction.dot(_temp_vel) > 0:
		_temp_accel = acceleration
		
	else:
		_temp_accel = deacceleration
	
	if not is_on_floor():
		_temp_accel *= air_control
	
	# Interpolation
	_temp_vel = _temp_vel.linear_interpolate(_target, _temp_accel * delta)
	
	velocity.x = _temp_vel.x
	velocity.z = _temp_vel.z
	
	# Make too low values zero
	if direction.dot(velocity) == 0:
		var _vel_clamp := 0.01
		if abs(velocity.x) < _vel_clamp:
			velocity.x = 0
		if abs(velocity.z) < _vel_clamp:
			velocity.z = 0


func jump() -> void:
	if _is_jumping_input:
		velocity.y = jump_height
		snap = Vector3.ZERO


func sprint(delta: float) -> void:
	if can_sprint():
		_speed = sprint_speed
		cam.set_fov(lerp(cam.fov, FOV * 1.05, delta * 8))
		sprinting = true
		
	else:
		_speed = walk_speed
		cam.set_fov(lerp(cam.fov, FOV, delta * 8))
		sprinting = false


func can_sprint() -> bool:
	return (sprint_enabled and is_on_floor() and _is_sprinting_input and move_axis.x >= 0.5)
