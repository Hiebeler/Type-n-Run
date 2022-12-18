extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 30
const JUMPFORCE = -900
var right = false
var left = false

func _physics_process(delta):
	if right:
		velocity.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("walk")
	elif left:
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
	
	if not is_on_floor():
		$Sprite.play("air")
	
	velocity.y = velocity.y + GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.1)


func _on_CommandInput_text_entered(input):
	if input == "right":
		right = true
		left = false
	elif input == "left":
		right = false
		left = true
	elif input == "jump":
		velocity.y = JUMPFORCE
	elif input == "stop":
		right = false
		left = false
	$"../CanvasLayer/Panel/CommandInput".clear()
