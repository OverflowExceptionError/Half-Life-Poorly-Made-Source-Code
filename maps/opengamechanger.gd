extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var Exte = 'gameui_change_game'
export(String) var chapter_name_path = 'chapters.cfg'
export(String) var mod_name_path = 'moddata.txt'
onready var gamechanger = load('res://maps/' + Exte + '.tscn').instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	if Exte == 'gameui_chapter_select':
		gamechanger.chapter_file_name = chapter_name_path
	if Exte == 'gameui_change_game':
		gamechanger.modmenu_file_name = mod_name_path
	get_parent().call_deferred('add_child',gamechanger)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		gamechanger.get_node('WindowDialog').visible = true
	pass
