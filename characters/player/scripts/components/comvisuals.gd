extends Node2D

onready var animated_sprite = get_node("../../Visuals/Texture");

func _process(_delta):
	_handle_animations()
	
func _handle_animations():
	
	if (Input.is_action_pressed("movement_up") || Input.is_action_pressed("movement_down") || Input.is_action_pressed("movement_right") || Input.is_action_pressed("movement_left")):
		animated_sprite.play("running");
		animated_sprite.speed_scale = 2;
	
	elif (Input.is_action_pressed("action_fire")):
		animated_sprite.play("attack");
		animated_sprite.speed_scale = 5;

	else: 
		animated_sprite.play("idle");
		animated_sprite.speed_scale = 1;
	
	
	
