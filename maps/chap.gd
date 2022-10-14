extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item = []
# Called when the node enters the scene tree for the first time.
func __ready():
	print(OS.get_executable_path().get_base_dir())
	var f = Filesys.load_text_file(OS.get_executable_path().get_base_dir() + '/gamedata/' + get_parent().chapter_file_name)
	if f == 'No file!':
		$ItemList.add_item('Failed to load chapter config!')
		item.append({'title':'','map':'c1a0'})
		$ItemList.set_item_tooltip(len(item) - 1, 'This means you\'re missing \"chapters.cfg\" in your \"gamedata\" folder.')
	else:
		for e in f.split('\n'):
			var h = e.split(' -> ')
			$ItemList.add_item(h[0])
			item.append({'title':h[0],'map':h[1]})
			if len(h) > 2:
				$ItemList.set_item_tooltip(len(item) - 1, h[2])
				$ItemList.set_item_tooltip_enabled(len(item) - 1,true)
# Called when the node enters the scene tree for the first time.
func _ready():
	print(ProjectSettings.globalize_path("res://"))
	print(get_parent().get_parent())
	print(get_parent().get_parent().get_parent())
	print(get_tree().root)
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
	get_tree().change_scene('res://maps/' + item[selected_item].map + '.tscn')
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
