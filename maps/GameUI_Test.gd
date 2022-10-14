extends FileDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func __init():
	# Window initialization
	if get_parent().get_parent() == get_tree().root: # A small snipet of code that shows the window when being executed directly
		visible = true
	for e in Globals.translation: # Changes the "GameUI_" title to a actual title (see res://globals.gd, line 9)
		if e.key == window_title:
			window_title = e.trans
# Called when the node enters the scene tree for the first time.
func _ready():
	#Don't touch this!
	__init()
	current_dir = OS.get_executable_path().get_base_dir() + '/gamedata'
	current_file = 'moddata.txt'
	current_path = OS.get_executable_path().get_base_dir() + '/gamedata/moddata.txt'
	#Now mess with it
	pass # Replace with function body..


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
