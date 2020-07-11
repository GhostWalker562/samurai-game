extends Node2D


# Declare member variables here. Examples:
# var a = 2
onready var component : Node2D = get_node("..");
onready var bullet : PackedScene = preload("res://vfx/bullet/Bullet.tscn");

# VARIABLES FOR HANDLING FIRING SPEED
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0
export(float) var fire_rate : float = 10 #Fire rate 10 bullets per second


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# HANDLE FIRING SPEED
	current_time += delta;
	if (current_time < update_delta):	
		return

	if (Input.is_action_pressed("action_fire")):
		current_time = 0;
		var bulletinstance = bullet.instance();
		var playerangle = component.get_aim_angle();
		add_child(bulletinstance);
		# Sets the bullet spawn location
		bulletinstance.global_position = get_global_position();
		# Sets the direction of the bullet
		bulletinstance.INITIAL_VECTOR = Vector2(sin(-playerangle),cos(playerangle))
		
	pass
