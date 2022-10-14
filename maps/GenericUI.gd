extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func __init():
	# Window initialization
	if Globals.gameui_forceFileBrowser: # This button is normally a button for the "Open File Browser" option.
		$Button3.visible = true
	if Globals.gameui_forceDisableFileBrowser: # This button is normally a button for the "Open File Browser" option.
		$Button3.visible = false
	if get_parent().get_parent() == get_tree().root: # A small snipet of code that shows the window when being executed directly
		visible = true
	for e in Globals.translation: # Changes the "GameUI_" title to a actual title (see res://globals.gd, line 9)
		if e.key == window_title:
			window_title = e.trans
# Called when the node enters the scene tree for the first time.
func _ready():
	#Don't touch this!
	__init()
	#Now mess with it
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	visible = false
	pass # Replace with function body.


func _on_Button2_pressed():
	visible = true
	pass # Replace with function body.


func _on_Button3_pressed():
	print('WOW! YOU PRESSED [THE BUTTON]!')
	pass # Replace with function body.
