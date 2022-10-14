extends Spatial

# GMScript 1.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String, MULTILINE) var GMScript = ''
var variables = []
var functions = []
export (NodePath) var player_path
onready var player = get_node(player_path)
export (NodePath) var level_path
onready var level = get_node(level_path)
var forever_run = false
# Called when the node enters the scene tree for the first time.
func run_trigger(retr):
	print('Base class: __iesl_loader')
	print('Inherits from: Spatial')
	print('Triggered!')
func _ready():
	$Sprite3D.visible = false
	print('This map uses the Interactive Element Scripting Language')
	print('GodSrc Mapper Script')
	print('Initializing...')
	var script = GMScript.split('\n')
	for e in script:
		e = e.split(' ')
		if e[0] == 'set_cursor_captured':
			if e[1] == 'true':
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if e[0] == 'get':
			# This function gets a data type of either "player", "level" or "map"
			if e[1] == 'player':
				if e[2] == 'set_position':
					player.translation = Vector3(int(e[3]),int(e[4]),int(e[5]))
				if e[2] == 'set_rotation':
					player.rotation_degrees = Vector3(int(e[3]),int(e[4]),int(e[5]))
				if e[2] == 'delete':
					level.remove_child(get_node('ViewportContainer'))
					player = null
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					forever_run = true
			if e[1] == 'level':
				if e[2] == 'get_node_as_var':
					variables.append({'name':e[3],'value':level.get_node(e[3])})
				if e[2] == 'adjust_player_viewport_size':
					level.get_node('ViewportContainer/Viewport').size.x = int(e[3])
					level.get_node('ViewportContainer/Viewport').size.y = int(e[4])
			if e[1] == 'map':
				if e[2] == 'change':
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					get_tree().change_scene(e[3])
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if e[0] == 'create_trigger':
			var trig = Area.new()
			var area = BoxShape.new()
			area.extents.x = float(e[1])
			area.extents.y = float(e[2])
			area.extents.z = float(e[3])
			var a = CollisionShape.new()
			a.shape = area
			trig.add_child(a)
			trig.translation.x = float(e[4])
			trig.translation.y = float(e[5])
			trig.translation.z = float(e[6])
			trig.set_script(load('res://trigger.gd'))
			trig.object = get_node(e[7])
			trig.name = e[8]
			trig.state = int(e[9])
			print('Created new trigger at ' + e[4] + ', ' + e[5] + ', ' + e[6])
			get_parent().call_deferred('add_child',trig)
		if e[0] == 'create_door':
			var i = load('res://ent_door.tscn').instance()
			i.translation = Vector3(float(e[1]),float(e[2]),float(e[3]))
			if len(e) > 6:
				i.rotation_degrees = Vector3(float(e[4]),float(e[5]),float(e[6]))
				if len(e) > 7:
					i.name = e[7]
			else:
				if len(e) > 4:
					i.name = e[4]
			level.call_deferred('add_child', i)
			pass
		if e[0] == 'create_elevator':
			var i = load('res://ent_moving_platform.tscn').instance()
			i.translation = Vector3(float(e[1]),float(e[2]),float(e[3]))
			if len(e) > 6:
				i.rotation_degrees = Vector3(float(e[4]),float(e[5]),float(e[6]))
				if len(e) > 7:
					i.name = e[7]
			else:
				if len(e) > 4:
					i.name = e[4]
			level.call_deferred('add_child', i)
			pass
		if e[0] == 'create_glass':
			var i = load('res://ent_glass.tscn').instance()
			i.translation = Vector3(float(e[1]),float(e[2]),float(e[3]))
			if len(e) > 5:
				i.rotation_degrees = Vector3(float(e[4]),float(e[5]),float(e[6]))
				if len(e) > 7:
					i.name = e[7]
					if len(e) > 8:
						i.health = int(e[8])
			else:
				if len(e) > 4:
					i.name = e[4]
			level.call_deferred('add_child', i)
			pass
		if e[0] == 'add_translation':
			var stri = ''
			for f in e:
				if f != e[0] and f != e[1]:
					stri += f + ' '
			Globals.translation.append({'key':e[1],'trans':stri})
		if e[0] == 'create_hudtext':
			var i = Label.new()
			i.rect_size = Vector2(320,240)
			i.text = e[1]
			i.set_script(load('res://maps/GameText.gd'))
			player.get_parent().add_child(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forever_run:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
