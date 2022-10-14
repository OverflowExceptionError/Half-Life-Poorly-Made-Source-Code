extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var health = 1
export(bool) var funni = false
export(bool) var my = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func run_trigger(state):
	if state == 0:
		health = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		var shard1 = load('res://models/glass/shard1.tscn').instance()
		var shard2 = load('res://models/glass/shard2.tscn').instance()
		var shard3 = load('res://models/glass/shard3.tscn').instance()
		get_parent().add_child(shard1)
		get_parent().add_child(shard2)
		get_parent().add_child(shard3)
		if not funni:
			shard1.transform.origin = self.transform.origin
			shard2.transform.origin = self.transform.origin
			shard3.transform.origin = self.transform.origin
			shard1.rotation = self.rotation
			shard2.rotation = self.rotation
			shard3.rotation = self.rotation
			shard1.scale = self.scale
			shard2.scale = self.scale
			shard3.scale = self.scale
			get_parent().remove_child(self)
		#if my:
		#	shard1.transform.origin = self.transform.origin
		#	shard2.transform.origin = self.transform.origin
		#	shard3.transform.origin = self.transform.origin
		#	shard1.rotation = self.rotation
		#	shard2.rotation = self.rotation
		#	shard3.rotation = self.rotation
	pass
