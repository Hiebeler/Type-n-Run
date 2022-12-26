extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const SPRINTSPEED = 300
const GRAVITY = 30
const JUMPFORCE = -900
const SPRINGFORCE = -1500
const RIGHT = "right"
const LEFT = "left"
const JUMP = "jump"
const CROUCH = "crouch"
const DASH = "dash"
const STOP = "stop"
const SPRINT = "sprint"
enum StatesWalking { IDLE = 1, RIGHT, SPRINTRIGHT, LEFT, SPRINTLEFT }
var stateWalking = StatesWalking.IDLE
enum Facings { RIGHT = 1, LEFT}
var facing = Facings.RIGHT
var JumpCounter = 0
var crouch = false
var crouchTimer

var canDash = true
var dashing = false
var dashDirection = Vector2.ZERO

func _ready():
	SignalBus.connect("LineEntered", self, "lineEntered")
	SignalBus.connect("SpringEntered", self, "spring")
	crouchTimer = Timer.new()
	add_child(crouchTimer)
	crouchTimer.wait_time = 1
	crouchTimer.connect("timeout", self, "stopCrouch")
	

func _physics_process(delta):
	move()
	
	if not is_on_floor():
		$Sprite.play("air")
	
	velocity.y = velocity.y + GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.1)

func jump():
	if is_on_floor():
		JumpCounter = 0
	JumpCounter += 1
	if JumpCounter <= 2:
		velocity.y = JUMPFORCE


func spring():
	if is_on_floor():
		JumpCounter = 0
	JumpCounter += 1
	if JumpCounter <= 2:
		velocity.y = SPRINGFORCE

func dash():
	if canDash:
		if facing == Facings.RIGHT:
			dashDirection = Vector2(1,0)
		if facing == Facings.LEFT:
			dashDirection = Vector2(-1,0)
		velocity = dashDirection.normalized() * 3000
		canDash = false
		dashing = true
		yield(get_tree().create_timer(0.5), "timeout")
		dashing = false
		canDash = true
	
func move():
	if not dashing:
		match stateWalking:
			StatesWalking.IDLE:
				$Sprite.play("idle")
			StatesWalking.RIGHT:
				velocity.x = SPEED
				$Sprite.flip_h = false
				$Sprite.play("walk")
			StatesWalking.SPRINTRIGHT:
				velocity.x = SPRINTSPEED
				$Sprite.flip_h = false
				$Sprite.play("walk")
			StatesWalking.LEFT:
				velocity.x = -SPEED
				$Sprite.flip_h = true
				$Sprite.play("walk")
			StatesWalking.SPRINTLEFT:
				velocity.x = -SPRINTSPEED
				$Sprite.flip_h = true
				$Sprite.play("walk")
		if crouch:
			$Sprite.play("crouch")

func stopCrouch():
	$CollisionShape2D.scale = Vector2(1, 1)
	if crouch:
		$Sprite.position = Vector2($Sprite.position.x, $Sprite.position.y + 6)
	crouch = false

func startCrouch():
	crouch = true
	crouchTimer.start()
	$CollisionShape2D.scale = Vector2(1, 0.8)
	$Sprite.position = Vector2($Sprite.position.x, $Sprite.position.y - 6)
	

func lineEntered(input):
	if input == RIGHT:
		stateWalking = StatesWalking.RIGHT
		facing = Facings.RIGHT
	elif input == (SPRINT + " " + RIGHT):
		stateWalking = StatesWalking.SPRINTRIGHT
		facing = Facings.RIGHT
	elif input == LEFT:
		stateWalking = StatesWalking.LEFT
		facing = Facings.LEFT
	elif input == (SPRINT + " " + LEFT):
		stateWalking = StatesWalking.SPRINTLEFT
		facing = Facings.LEFT
	elif input == JUMP:
		jump()
	elif input == CROUCH and not crouch:
		startCrouch()
	elif input == DASH:
		dash()

	elif input == STOP:
		stateWalking = StatesWalking.IDLE
	$"../CanvasLayer/Panel/CommandInput".clear()
