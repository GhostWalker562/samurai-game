extends Node2D

onready var particles = get_node("rnwlk");

func _process(_delta):
	_handle_particles()
	
func _handle_particles():
	var emit : bool = false
	
	if (Input.is_action_pressed("movement_up")):
		emit = true
	elif (Input.is_action_pressed("movement_down")):
		emit = true
	elif (Input.is_action_pressed("movement_right")):
		emit = true
	elif (Input.is_action_pressed("movement_left")):
		emit = true
	
	particles.emitting = emit;
	
