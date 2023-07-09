extends RigidBody2D

signal enemy_hit

@export var speed = 200

var track_to_follow: PathFollow2D
var track_progress: float = 0.0

# To change the Gun, alter it in the node inspector of your ship scene

func _physics_process(delta):
	follow_track(delta)
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

func follow_track(delta):
	if track_to_follow is PathFollow2D:
		track_progress += speed * delta
		track_to_follow.progress = track_progress
		position = track_to_follow.position
		rotation = track_to_follow.rotation
		if track_to_follow.progress_ratio >= 0.98:
			hide()
			queue_free()
