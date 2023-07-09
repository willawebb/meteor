extends RigidBody2D

var hp = 25

func _ready():
	add_to_group("asteroids")

func take_damage(dmg):
	hp -= dmg
	if hp < 0:
		#Need to add something to show the asteroid blowing up!
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
