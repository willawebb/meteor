extends RigidBody2D

signal enemy_hit(position, starting_point)

@export var speed = 150

@export_range(1, 1000) var bullet_speed = 100

@export_range(1, 64) var spawn_points = 1 # how many guns are firing.

@export_range(1, 1000) var spawn_distance = 20 # distance from centre of gun that rotator points are at.

@export_range(0, 360, 0.1) var rotate_speed: float = 10.0 # degrees per second.

@export var fire_rate: Array[float] = [2.0]

var track_to_follow: PathFollow2D
var track_progress: float = 0.0
var track_rotation: float = 0.0
var starting_point: Vector2

func _ready():
	hide()
	add_to_group("ships")
	$Gun.bullet_speed = bullet_speed
	$Gun.spawn_points = spawn_points
	$Gun.spawn_distance = spawn_distance
	$Gun.rotate_speed = rotate_speed
	$Gun.fire_rate = fire_rate
	$Gun.start()

# To change the Gun, alter it in the node inspector of your ship scene

func _integrate_forces(state):
	follow_track(state)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # queue_free()

func _on_body_entered(_body):
	hide()
	enemy_hit.emit(position, starting_point)
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
		if track_to_follow.progress_ratio >= 0.001:
			show()
		if track_to_follow.progress_ratio >= 0.98:
			queue_free()
	
