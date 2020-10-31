extends KinematicBody2D

var velocity = Vector2()
export var direction = -1
export var detects_cliff = true

var speed = 50
const GRAVITY = 20


func _ready():
	if detects_cliff:
		set_modulate(Color(1.2,0.5,1))
	flip()
	
func _physics_process(delta):
	
	## if enemy does not detect a floor under the ray cast 
	## then the enemy is at the edge of the platform and 
	## would fall off if it kept going.  But the deteect cliff
	## option must also be true
	var detect_drop_off = not $floor_checker.is_colliding() and detects_cliff
	
	## if enemy is collioding with a wall or other object or it has 
	## detect a cliff then reverse.  is-on_floor prevents enemy from 
	## flipping if he's falling.  
	if  is_on_wall() or (detect_drop_off and is_on_floor()):
		direction *= -1
		flip()
	
	velocity.y += GRAVITY
	
	velocity.x = speed * direction 
	velocity = move_and_slide(velocity, Vector2.UP)
	
func flip():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("squash")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$side_checker.set_collision_layer_bit(4, false)
	$side_checker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()
	body.kill_count()
		
func _on_side_checker_body_entered(body):
	##print("collide with player")
	body.ouch(position.x)
	


func _on_Timer_timeout():
	queue_free()
	
