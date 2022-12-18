extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 30
const JUMPFORCE = -900
const RIGHT = "right"
const LEFT = "left"
const JUMP = "j"
const STOP = "stop"
enum StatesWalking { IDLE = 1, RIGHT, LEFT }
var stateWalking = StatesWalking.IDLE
var JumpCounter = 0

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

func move():
	match stateWalking:
		StatesWalking.IDLE:
			$Sprite.play("idle")
		StatesWalking.RIGHT:
			velocity.x = SPEED
			$Sprite.flip_h = false
			$Sprite.play("walk")
		StatesWalking.LEFT:
			velocity.x = -SPEED
			$Sprite.flip_h = true
			$Sprite.play("walk")

func _on_CommandInput_text_entered(input):
	if input == RIGHT:
		stateWalking = StatesWalking.RIGHT
	elif input == LEFT:
		stateWalking = StatesWalking.LEFT
	elif input == JUMP:
		jump()
	elif input == STOP:
		stateWalking = StatesWalking.IDLE
	$"../CanvasLayer/Panel/CommandInput".clear()
