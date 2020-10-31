extends KinematicBody2D

var velocity = Vector2(0, 0)
var canDoubleJump = false
var coins = 0
var lives = 3
var kills = 0
var coin_lives = 5
var kill_lives = 5
var safe_timer = 3
var win_count = 3

const SPEED = 210
const GRAVITY = 35
const JUMPFORCE = -1100
const MAXJUMPS = 2

onready var huds = get_tree().get_nodes_in_group("HUD")

func _ready():
	huds[0].update_coin(coins)
	huds[0].update_lives(lives)
	huds[0].update_kills(kills)

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
	
	##if (coins == 3):
	##	get_tree().change_scene("res://Levels/Level1.tscn")	
	
func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Extras/YouLose.tscn")

func coin_count():
	coins += 1
	##print("I now have this many coins: ", coins)
	huds[0].update_coin(coins)
	if (coins % coin_lives) == 0:
		lives += 1
		huds[0].update_lives(lives)
	if (coins == win_count):
		get_tree().change_scene("res://Extras/YouWin.tscn")
		
func kill_count():
	kills += 1
	huds[0].update_kills(kills)
	if (kills % kill_lives) == 0:
		lives += 1
		huds[0].update_lives(lives)		
		
func bounce():
	velocity.y = JUMPFORCE * 0.3

func ouch(enemyposx):
	var temp
	lives -= 1
	huds[0].update_lives(lives)	
	set_modulate(Color(1,0.3,0.3,0.4))
	velocity.y = JUMPFORCE * 0.3
	if position.x < enemyposx:
		velocity.x = SPEED * -1 * 2
	elif position.x > enemyposx:
		velocity.x = SPEED * 2
	Input.action_release("left")
	Input.action_release("right")
	Input.action_release("jump")
	$Timer.start()	

func _on_Timer_timeout():
	get_tree().change_scene("res://Extras/YouLose.tscn")
