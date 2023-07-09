extends RigidBody2D

signal enemy_hit

@export var speed = 200

var track_to_follow: PathFollow2D
var track_progress: float = 0.0

# To change the Gun, alter it in the node inspector of your ship scene

func _integrate_forces(state):
	follow_track(state)
	# velocity.x = move_toward(velocity.x, 0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body):
	hide()
	enemy_hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)
	queue_free()
	
	pass # create an explosion effect?

func set_track(track: PathFollow2D):
	track_to_follow = track

func follow_track(state):
	if track_to_follow is PathFollow2D:
		track_progress += speed * state.step
		track_to_follow.progress = track_progress
		state.transform.origin.x = track_to_follow.position.x
		state.transform.origin.y = track_to_follow.position.y
		rotation = track_to_follow.rotation
		if track_to_follow.progress_ratio >= 0.98:
			queue_free()
