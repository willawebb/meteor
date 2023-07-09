extends RichTextLabel


var blinking_space = true

func _process(delta):

func _on_blinken_timeout():
	for i in range(11):
		visible_ratio = i/11
		await(get_tree().create_timer(0.4).timeout)
