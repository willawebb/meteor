extends RigidBody2D

signal enemy_hit(position)

@export var speed = 150

var track_to_follow: PathFollow2D
var track_progress: float = 0.0
var track_rotation: float = 0.0
var starting_point: Vector2

func _ready():
	add_to_group("ships")

# To change the Gun, alter it in the node inspector of your ship scene

func _integrate_forces(state):
	follow_track(state)

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # queue_free()

func _on_body_entered(_body):
	hide()
	enemy_hit.emit(position)
	$CollisionPolygon2D.set_deferred("disabled", true)
	queue_free()

func set_track(track: PathFollow2D, start: Vector2):
	track_to_follow = track
	starting_point = start

func follow_track(state):
	if track_to_follow is PathFollow2D:
		track_progress += speed * state.step
		track_to_follow.progress = track_progress
		state.transform.origin.x = track_to_follow.position.x + starting_point.x
		state.transform.origin.y = track_to_follow.position.y + starting_point.y
		state.transform = state.transform.rotated_local(track_to_follow.rotation - track_rotation)
		track_rotation = track_to_follow.rotation
		if track_to_follow.progress_ratio >= 0.98:
			queue_free()
	
