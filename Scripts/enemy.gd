extends KinematicBody2D

var velocity = Vector2()
export var direction = -1
export var detects_cliff = true

const SPEED = 50
const GRAVITY = 20


func _ready():
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
	
	velocity.x = SPEED * direction 
	velocity = move_and_slide(velocity, Vector2.UP)
	
func flip():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
