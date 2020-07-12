extends Node2D




# Declare member variables here. Examples:
# var a = 2
onready var component : Node2D = get_node("..");
onready var bullet : PackedScene = preload("res://vfx/bullet/Bullet.tscn");

# VARIABLES FOR HANDLING FIRING SPEED
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0
export(float) var fire_rate : float = 10 #Fire rate 10 bullets per second

# VARIABLES FOR HANDLING BULLETS
var bullets : int = 50;
var capacity : int = 50;
var empty : bool = false; 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# HANDLE FIRING SPEED
	current_time += delta;
	if (current_time < update_delta):	
		return
	_handle_shooting();
	_handle_text();


func _handle_shooting():
	if (Input.is_action_pressed("action_fire")):
		if (bullets == 0):
			empty = true;
			reload();
			return;
		current_time = 0;
		var bulletinstance = bullet.instance();
		var playerangle = component.get_aim_angle();
		# Sets the bullet spawn location
		bulletinstance.global_position = get_global_position();
		# Sets the direction of the bullet
		bulletinstance.INITIAL_VECTOR = Vector2(sin(-playerangle),cos(playerangle))
		bulletinstance.visible = true;
		add_child(bulletinstance);
		
		
		# HANDLE BULLETS
		bullets -=1;
		

func reload():
	yield(get_tree().create_timer(1),"timeout");
	empty = false;
	bullets = capacity;

func _handle_text():
	if (empty):
		component.get_gui().ammo_text = "RELOADING";
	else:
		component.get_gui().ammo_text = "" + str(bullets) + "/" + str(capacity);
