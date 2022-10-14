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
func _ready():
	print('This map uses a GM Script!')
	print('GodSrc Mapper Script')
	print('Initializing...')
	var script = GMScript.split('\n')
	for e in script:
		e = e.split(' ')
		if e[0] == 'get':
			# This function gets a data type of either "player", "level" or "map"
			if e[1] == 'player':
				if e[2] == 'set_position':
					player.translation = Vector3(int(e[3]),int(e[4]),int(e[5]))
				if e[2] == 'set_rotation':
					player.rotation_degrees = Vector3(int(e[3]),int(e[4]),int(e[5]))
			if e[1] == 'level':
				if e[2] == 'get_node_as_var':
					variables.append({'name':e[3],'value':level.get_node(e[3])})
				if e[2] == 'adjust_player_viewport_size':
					level.get_node('ViewportContainer/Viewport').size.x = int(e[3])
					level.get_node('ViewportContainer/Viewport').size.y = int(e[4])
			if e[1] == 'map':
				if e[2] == 'change':
					get_tree().change_scene(e[3])
		if e[0] == 'var':
			variables.append({'name':e[1],'value':e[2]})
		if e[0] == 'create':
			# This function creates an object of either "CSGBox", "door", "elevator", or "glass"
			if e[1] == 'CSGBox':
				var i = CSGBox.new()
				i.translation = Vector3(float(e[2]),float(e[3]),float(e[4]))
				i.width = float(e[5])
				i.depth = float(e[7])
				i.height = float(e[6])
				i.use_collision = true
				if len(e) > 10:
					i.rotation_degrees = Vector3(float(e[8]),float(e[9]),float(e[10]))
					if len(e) > 11:
						i.use_collision = bool(e[11])
						if len(e) > 12:
							i.material = load(e[12])
				level.call_deferred('add_child', i)
				pass
			if e[1] == 'door':
				var i = load('res://ent_door.tscn').instance()
				i.translation = Vector3(float(e[2]),float(e[3]),float(e[4]))
				if len(e) > 7:
					i.rotation_degrees = Vector3(float(e[5]),float(e[6]),float(e[7]))
				level.call_deferred('add_child', i)
				pass
			if e[1] == 'elevator':
				var i = load('res://ent_moving_platform.tscn').instance()
				i.translation = Vector3(float(e[2]),float(e[3]),float(e[4]))
				if len(e) > 7:
					i.rotation_degrees = Vector3(float(e[5]),float(e[6]),float(e[7]))
				level.call_deferred('add_child', i)
				pass
			if e[1] == 'glass':
				var i = load('res://ent_glass.tscn').instance()
				i.translation = Vector3(float(e[2]),float(e[3]),float(e[4]))
				if len(e) > 7:
					i.rotation_degrees = Vector3(float(e[5]),float(e[6]),float(e[7]))
					if len(e) > 8:
						i.health = int(e[8])
				level.call_deferred('add_child', i)
				pass
			if e[1] == 'gametext' or e[1] == 'Label':
				var i = Label.new()
				i.align = Label.ALIGN_CENTER
				i.valign = Label.VALIGN_CENTER
				i.rect_size = Vector2(320,240)
				i.text = e[2]
				i.rect_position = Vector2(0,0)
				i.margin_bottom = 240
				i.margin_right = 320
				i.margin_left = 0
				i.margin_top = 0
				level.get_node("ViewportContainer/Viewport").call_deferred('add_child',i)
			if e[1] == 'temp_gametext': # Used for something like a GMScript-based chapter title in maps lacking the transition component.
				var i = Label.new()
				i.align = Label.ALIGN_CENTER
				i.valign = Label.VALIGN_CENTER
				i.rect_size = Vector2(320,240)
				i.text = e[2]
				i.rect_position = Vector2(0,0)
				i.margin_bottom = 240
				i.margin_right = 320
				i.margin_left = 0
				i.margin_top = 0
				level.get_node("ViewportContainer/Viewport").call_deferred('add_child',i)
				yield(get_tree().create_timer(float(e[3])),"timeout")
				level.get_node("ViewportContainer/Viewport").call_deferred('remove_child',i)
			if e[1] == 'delay':
				yield(get_tree().create_timer(float(e[2])),"timeout")
			pass
		if e[0] == 'opengamemenu':
			var i = load('res://maps/' + e[1] + '.tscn').instance()
			get_parent().add_child(i)
			i.get_node('WindowDialog').visible = true
			level.remove_child(get_node('ViewportContainer'))
			player = null
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			forever_run = true
		if e[0] == 'openfilebrowser':
			var i = load('res://maps/gameui_filebrowser.tscn').instance()
			get_parent().add_child(i)
			i.get_node('WindowDialog').visible = true
			var stri = []
			i.exec_script = e[1]
			for f in e:
				if f != e[0] and f != e[1]:
					stri.append(f)
			i.filters = stri
			level.remove_child(get_node('ViewportContainer'))
			player = null
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			forever_run = true
		if e[0] == 'exec_iesl':
			if e[1] == 'add_translation':
				var stri = ''
				for f in e:
					if f != e[0] and f != e[1] and f != e[2]:
						stri += f + ' '
				Globals.translation.append({'key':e[2],'trans':stri})
			if e[1] == 'create_hudtext':
				var i = Label.new()
				i.rect_size = Vector2(320,240)
				i.text = e[2]
				i.set_script(load('res://maps/GameText.gd'))
				player.get_parent().add_child(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forever_run:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
