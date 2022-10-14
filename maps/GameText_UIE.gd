extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	if Globals.gameui_forceDisableFileBrowser:
		$Button3.visible = false
	if get_parent().get_parent() == get_tree().root:
		visible = true
	for e in Globals.translation:
		if e.key == window_title:
			window_title = e.trans
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Button2_pressed():
	visible = false
	pass # Replace with function body.
var current_selected_item = 0

func _on_Button_pressed():
	print(current_selected_item)
	var success = ProjectSettings.load_resource_pack("res://gamedata/mods/" + $ItemList.item[current_selected_item].pck + ".pck")
	if success:
		# Now one can use the assets as if they had them in the project from the start.
		get_tree().change_scene('res://maps/mm.tscn')
	visible = false
	pass # Replace with function body.


func _on_ItemList_item_selected(index):
	current_selected_item = index
	pass # Replace with function body.


func _on_Button3_pressed():
	OS.shell_open(OS.get_executable_path().get_base_dir() + '/gamedata')
	pass # Replace with function body.
