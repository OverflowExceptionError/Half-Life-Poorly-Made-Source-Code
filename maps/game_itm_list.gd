extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item = []
# Called when the node enters the scene tree for the first time.
func _ready():
	add_item('HALF-LIFE but it\'s poorly made')
	item.append({'title':'HALF-LIFE but it\'s poorly made','pck':'no pck here, base game!'})
	set_item_tooltip(0,'This is the base game!')
	print(OS.get_executable_path().get_base_dir())
	var f = Filesys.load_text_file(OS.get_executable_path().get_base_dir() + '/gamedata/' + get_parent().get_parent().modmenu_file_name)
	if f == 'No file!':
		pass
	else:
		for e in f.split('\n'):
			var h = e.split(' | ')
			add_item(h[0])
			item.append({'title':h[0],'pck':h[1]})
			if len(h) > 2:
				set_item_tooltip(len(item) - 1, h[2])
				set_item_tooltip_enabled(len(item) - 1,true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
