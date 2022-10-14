extends Node

var level_trans_dest = "default"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var replay_name = "session_data"
var gms = ""
var logfile = """INIT GAME!"""
var translation = [
	{
		'key':'GameText_WarnGUI_RequiresScreenRecorder',
		'trans':'In order for FilmMaker to work, you need a program like OBS Studio.'
	},
	{
		'key':'GameUI_GameChapterSelect',
		'trans':'CHAPTER SELECT'
	},
	{
		'key':'GameUI_Chapter1_Title',
		'trans':'Anomalous Materials'
	},
	{
		'key':'GameUI_QuitGameText',
		'trans':'Would you like to quit the game?'
	},
	{
		'key':'GameUI_GameSelector',
		'trans':'SELECT A MOD'
	},
	{
		'key':'GameUI_ReplayMenuHint',
		'trans':'Use the replay menu to load replays, or use it to freecam a map!'
	},
	{
		'key':'GameUI_ReplayMenuBTN',
		'trans':'REPLAY MENU'
	},
	{
		'key':'GameUI_FilmmakerBTN',
		'trans':'GODSRC FILMMAKER'
	},
	{
		'key':'GameUI_GameName',
		'trans':'HALF-LIFE'
	},
	{
		'key':'GameUI_GameSubtext',
		'trans':'but it\'s poorly made'
	},
	{
		'key':'GameUI_LegalMumboJumbo',
		'trans':"""Smorce 2 is property of VuLVE Game Studios - GDoom is property of CappleSoft LLC
GodSrc is licensed from CappleSoft under the GDoom engine."""
	},
	{
		'key':'GameUI_Chapter2_Title',
		'trans':'Unforeseen Consequences'
	},
	{
		'key':'GameUI_Chapter_Return_Title',
		'trans':'resenance complex'
	},
	{
		'key':'GameUI_Chapter_Prison_Title',
		'trans':"""anomaly 79:
The return of employee #225-b"""
	},
	{
		'key':'GameUI_FilmmakerHint',
		'trans':'This is a placeholder translation text'
	},
	{
		'key':'GameUI_GMScriptHint',
		'trans':'This is a button that executes your GMScript in real time!'
	},
	{
		'key':'GameUI_Cancel',
		'trans':'Cancel'
	},
	{
		'key':'GameUI_Ok',
		'trans':'OK'
	},
	{
		'key':'GameUI_FileBrowserText',
		'trans':'Open Game Dir in File Browser'
	},
	{
		'key':'GameUI_ExampleTitle',
		'trans':'Replace this with the name of your window!'
	},
	{
		'key':'GameUI_OpenFileDialog',
		'trans':'Load a file'
	}
]
var gameui_forceFileBrowser = false
var gameui_forceDisableFileBrowser = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
