extends KinematicBody2D

var velocity = Vector2(0, 0)
var canDoubleJump = false
var coins = 0

const SPEED = 210
const GRAVITY = 35
const JUMPFORCE = -1100
const MAXJUMPS = 2

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("walk")
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
	
	## for jumping and falling 	
	if not is_on_floor():
		$Sprite.play("jump")
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		canDoubleJump = false
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or canDoubleJump):
		if (! canDoubleJump):
			canDoubleJump = true
		else:
			canDoubleJump = false
		velocity.y = JUMPFORCE
	
	## print (canDoubleJump)
	## using "velocity =" prevents velocity y from continuing to 
	## increase from garvity above
	## Vectory2.UP = Vector2(0,-1)  It defines the UP direction 
	## it enable is_on_floor to work 
	velocity = move_and_slide(velocity, Vector2.UP)
		
	## lerp allows character to slow down when movement stops
	velocity.x = lerp(velocity.x,0,0.5)
	
	if (coins == 3):
		get_tree().change_scene("res://Levels/Level1.tscn")	
	
func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Levels/Level1.tscn")
	find_node()

func coin_count():
	coins += 1
	print("I now have this many coins: ", coins)

