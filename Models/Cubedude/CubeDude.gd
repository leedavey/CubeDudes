extends KinematicBody

const GRAVITY = -5

var motion = Vector3()
var canMove = true

export var playerId = 1
export var speed = 7
const EPSILON = 0.001

func _physics_process(delta):
	if canMove:
		move()
		animate()
	fall()

func canMove(value):
	canMove = value

func _process(delta):
	pass

func animate():
	if motion.length() > EPSILON:
		$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop(true)
	if not motion.x == 0 or not motion.z == 0:
		look_at(Vector3(-motion.x, 0, -motion.z)*speed, Vector3.UP)

func move():
	if Input.is_action_pressed("up%s" % playerId) and not Input.is_action_pressed("down%s" % playerId):
		motion.z = -1
	elif Input.is_action_pressed("down%s" % playerId) and not Input.is_action_pressed("up%s" % playerId):
		motion.z = 1
	else:
		motion.z = 0

	if Input.is_action_pressed("left%s" % playerId) and not Input.is_action_pressed("right%s" % playerId):
		motion.x = -1
	elif Input.is_action_pressed("right%s" % playerId) and not Input.is_action_pressed("left%s" % playerId):
		motion.x = 1
	else:
		motion.x = 0
	move_and_slide(motion.normalized()*speed, Vector3.UP, false)

func fall():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y = GRAVITY
