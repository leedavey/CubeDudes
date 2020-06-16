extends RigidBody

func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body is KinematicBody and not $KickSound.playing:
		$KickSound.play()
