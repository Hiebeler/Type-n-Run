extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var ledgeCheckLeft = $LedgeCheckLeft
onready var ledgeCheckRight = $LedgeCheckRight

func _physics_process(delta):
	var foundWall = is_on_wall()
	var foundLedge = not ledgeCheckLeft.is_colliding() or not ledgeCheckRight.is_colliding()
	if foundWall or foundLedge:
		direction *= -1
	
	velocity = direction * 100
	move_and_slide(velocity, Vector2.UP)
