extends Area2D

var collected = false

func _on_Coin_body_entered(body):
	##print("hit")
	## one way to prevent collision from
	## happening twice.  this clears a bit
	## in the collision mask
	set_collision_mask_bit(0, false)
	
	## another way to prevent collision from
	## happening twice
	if not collected:
		collected = true
		$AnimationPlayer.play("bounce")
		##print("hit")
		if body.has_method("coin_count"):
			body.coin_count()
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
