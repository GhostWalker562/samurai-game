

extends KinematicBody2D


export(float) var SPEED = 2.0;
export(int) var HEALTH = 250;
export(int) var DAMAGE = 15;

onready var nav_2d : Navigation2D = get_node("..");
onready var line : Line2D = get_node("../Line2D");
onready var ray: RayCast2D = get_node("Ray");
onready var hitbox : Area2D = get_node("Area2D");
onready var animation : AnimatedSprite = get_node("Texture");

var player;
var path : PoolVector2Array;


func _ready():
	player = get_node("../Player");

func _process(_delta):
	path = nav_2d.get_simple_path(self.global_position, player.global_position,true);
	if (ray.is_colliding()):
		set_process(false);
		attack();
	move_along_path(SPEED);

func _physics_process(_delta):
	_handle_health();


## HELPERS

func _handle_health():
	if (HEALTH <= 0):
		# DO ANIMATION
		# DIE
		queue_free();

func move_along_path(distance:float):
	var start_point := position;
	for i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if (distance <= distance_to_next && distance >= 0.0):
			var next = start_point.linear_interpolate(path[0],distance / distance_to_next);
			position = next;
			rotation = global_position.angle_to_point(player.global_position) + deg2rad(90);
			break
		elif (distance < 0.0):
			position = path[0];
			break
		distance -= distance_to_next;
		start_point = path[0];
		path.remove(0);


func attack():
	## PLAY ANIMATION
	animation.play("thrust")
	animation.speed_scale = 12;
	yield(get_tree().create_timer(0.5), "timeout");
	for child in hitbox.get_overlapping_bodies():
		if (child.is_in_group("player")):
			child.damage(50);
	yield(get_tree().create_timer(1), "timeout");
	set_process(true);

func damage(value : int):
	HEALTH -= value;
	# DO ANIMATION

func _on_Texture_animation_finished():
	if (animation.animation == "default"):
		return;
	animation.play("default");
	animation.speed_scale = 3;
