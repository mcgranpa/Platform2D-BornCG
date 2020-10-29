extends Area2D

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	##print("hit")
	body.coin_count()
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
