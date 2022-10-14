extends CSGBox
var player_pos_data = ""
var egg = false
var increa = 0
func _ready():
	player_pos_data = Filesys.load_file('user://' + Globals.replay_name + '.txt')
	if player_pos_data == 'No file!':
		get_tree().quit()
	pass
func _process(delta):
	increa += 1
	if len(player_pos_data.split('\n')) != increa:
		var e = player_pos_data.split('\n')[increa]
		#print(e)
		if len(e) == 1:
			pass
		else:
			var helpme = e.split(' ')
			#print(helpme)
			if len(helpme) != 1:
				print(translation)
				translation = Vector3(int(helpme[0]),int(helpme[1]),int(helpme[2]))
				rotation_degrees = Vector3(int(helpme[3]),int(helpme[4]),int(helpme[5]))
				#if len(helpme) > 8:
				#	$Head.rotation_degrees = Vector3(int(helpme[6]),int(helpme[7]),int(helpme[8]))
	else:
		increa = 0
	pass
# egg = false: Old DOOM style movement physics
# egg = true: Standard Smorce 2 movement physics
# Called every frame. 'delta' is the elapsed time since the previous frame

# Called every physics tick. 'delta' is constant


# Called when there is an input event

