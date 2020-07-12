extends Navigation2D


func _process(delta):
	if(get_children().size() ==4):
		get_node("Player")._play_win();
		set_process(false)
		yield(get_tree().create_timer(7),"timeout")
		get_tree().quit()
