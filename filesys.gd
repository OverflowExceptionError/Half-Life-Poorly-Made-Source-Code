extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ammo = 100
var health = 100000
var build = "10092022"
func write_file(file,text):
	var temp_file = File.new()
	temp_file.open(file, File.WRITE)
	temp_file.store_var(text)
	temp_file.close()
func load_file(file):
	var temp_file = File.new()
	if temp_file.file_exists(file):
		temp_file.open(file, File.READ)
		var temp_contents = temp_file.get_var()
		temp_file.close()
		return temp_contents
	else:
		return "No file!"
func write_text_file(fil,content):
	var file = File.new()
	file.open(fil, File.WRITE)
	file.store_string(content)
	file.close()

func load_text_file(fil):
	var file = File.new()
	if file.file_exists(fil):
		file.open(fil, File.READ)
		var content = file.get_as_text()
		file.close()
		return content
	else:
		return 'No file!'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
