extends KinematicBody
enum {
	IDLE,
	WANDER
}

var velocity = Vector3.ZERO
var state = IDLE

const ACCELERATION = 300
const MAX_SPEED = 50
const TOLERANCE = 4.0
export(bool) var following_player = false
export(NodePath) var player_path
onready var start_position = global_transform.origin
onready var target_position
func _ready():
	if following_player:
		target_position = get_node(player_path).global_transform.origin
	else:
		target_position = global_transform.origin
var target_vector = Vector3()
func update_target_position():
	if not following_player:
		target_vector = Vector3(rand_range(-32, 32),0, rand_range(-32, 32))
	else:
		target_vector = get_node(player_path).global_transform.origin
	target_position = start_position + target_vector

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - global_transform.origin).length() < TOLERANCE

func _physics_process(delta):
	match state:
		IDLE:
			state = WANDER
			# Maybe wait for X seconds with a timer before moving on
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)

			if is_at_target_position():
				state = IDLE

	velocity = move_and_slide(velocity)

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_transform.origin).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	if velocity.x > MAX_SPEED:
		velocity.x = MAX_SPEED
	if velocity.y > MAX_SPEED:
		velocity.y = MAX_SPEED
	if velocity.z > MAX_SPEED:
		velocity.z = MAX_SPEED
	#velocity = velocity.clamped(MAX_SPEED)
