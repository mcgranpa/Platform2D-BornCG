extends KinematicBody2D

var velocity = Vector2()
export var direction = -1

const SPEED = 50
const GRAVITY = 20


func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	
func _physics_process(delta):
	if  is_on_wall():
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	
	velocity.y += GRAVITY
	
	velocity.x = SPEED * direction 
	velocity = move_and_slide(velocity, Vector2.UP)
	
