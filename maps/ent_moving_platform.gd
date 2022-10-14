extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var riding = false
export(Vector3) var direction = Vector3(0,0.01,0)
export(bool) var two = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if two:
		$CSGBox5.visible = false
		$CSGBox5.use_collision = false
		$ent_door2.visible = true
		$CSGBox8.visible = true
	pass # Replace with function body.
func run_trigger(state):
	if state == 0:
		riding = false
	if state == 1:
		riding = true
	if state == 2:
		riding = false
		$ent_door.run_trigger(state - 2)
		$ent_door2.run_trigger(state - 2)
	if state == 3:
		riding = true
		$ent_door.run_trigger(state - 2)
		$ent_door2.run_trigger(state - 2)
	if state == 4:
		#riding = false
		$ent_door.run_trigger(state - 4)
		$ent_door2.run_trigger(state - 4)
	if state == 5:
		#riding = true
		$ent_door.run_trigger(state - 4)
		$ent_door2.run_trigger(state - 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riding:
		self.translation += direction
	pass


func _on_Area_body_entered(body):
	if body.name == 'Player':
		riding = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	if body.name == 'Player':
		riding = false
	pass # Replace with function body.
