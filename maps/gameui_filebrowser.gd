extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PoolStringArray) var filters
export(String) var exec_script = 'file_selected.gd'
# Called when the node enters the scene tree for the first time.
func _ready():
	$WindowDialog.filters = filters
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$WindowDialog.filters = filters
	pass


func _on_WindowDialog_file_selected(path):
	print(path)
	var gg = Node.new()
	gg.set_script(OS.get_executable_path().get_base_dir() + '/gamedata/scripts/' + exec_script)
	gg.file = path
	get_parent().add_child(gg)
	pass # Replace with function body.
