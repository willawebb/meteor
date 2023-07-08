extends Area2D


func _ready():
	
	viewport.size = get_viewport_rect().size
	$CollisionShape2D.set_shape(viewport)
