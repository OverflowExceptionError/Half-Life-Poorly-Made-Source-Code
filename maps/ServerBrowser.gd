extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item = []
# Called when the node enters the scene tree for the first time.
func __ready():
	print(OS.get_executable_path().get_base_dir())
	var f = Filesys.load_text_file(OS.get_executable_path().get_base_dir() + '/gamedata/' + get_parent().server_config_path)
	var a = 'GameUI_ServerCFG_FailLoad'
	if f == 'No file!':
		for e in Globals.translation:
				if e.key == a:
					a = e.trans
		$ItemList.add_item(a)
		item.append({'title':'','ip':'127.0.0.1'})
		$ItemList.set_item_tooltip(len(item) - 1, 'This means you\'re missing \"servers.cfg\" in your \"gamedata\" folder.')
	else:
		for e in f.split('\n'):
			var h = e.split(' | ')
			for g in Globals.translation:
				if g.key == h[0]:
					h[0] = g.trans
			$ItemList.add_item(h[0])
			item.append({'title':h[0],'ip':h[1]})
			if len(h) > 2:
				$ItemList.set_item_tooltip(len(item) - 1, h[2])
				$ItemList.set_item_tooltip_enabled(len(item) - 1,true)
# Called when the node enters the scene tree for the first time.
func _ready():
	for e in get_children():
		if e.get_class() == 'Button':
			for f in Globals.translation:
				if f.key == e.text:
					e.text = f.trans
	if Globals.gameui_forceFileBrowser:
		$Button3.visible = true
	if get_parent().get_parent() == get_tree().root:
		visible = true
	for e in Globals.translation:
		if e.key == window_title:
			window_title = e.trans
	__ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var selected_item = 0
func _on_Button_pressed():
	#add server connection here
	print('Connecting to ' + item[selected_item].ip)
	visible = false
	pass # Replace with function body.


func _on_Button2_pressed():
	visible = false
	pass # Replace with function body.

func _on_Button3_pressed():
	OS.shell_open(OS.get_executable_path().get_base_dir() + '/gamedata')
	pass # Replace with function body.


func _on_ItemList_item_selected(index):
	selected_item = index
	pass # Replace with function body.
