extends Spatial

# DOOMED WADMAP Loader
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print('Locating WADCFG.TXT')
	print('Located by default in %appdata%/Godot/app_userdata/DOOMED -to fail')
	if Filesys.load_file('user://wadcfg.txt') == 'No file!':
		print('Error! Cannot locate user://wadcfg.txt')
	else:
		print('Found WAD Configuration file!')
		print('WAD info:')
		print('Name: ' + Filesys.load_file('user://wadcfg.txt').split('\n')[0])
		print('WAD Menu: ' + Filesys.load_file('user://wadcfg.txt').split('\n')[1])
		print('Description: ' + Filesys.load_file('user://wadcfg.txt').split('\n')[2])
		print('WAD data: ' + Filesys.load_file('user://wadcfg.txt'))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Filesys.load_file('user://wadcfg.txt') == 'No file!':
		get_tree().change_scene('user://default.tscn')
	else:
		get_tree().change_scene('user://' + Filesys.load_file('user://wadcfg.txt').split('\n')[1] + '.tscn')
	pass
