extends KinematicBody2D


export(float) var SPEED = 2.0;
export(int) var HEALTH = 250;
export(int) var DAMAGE = 15;

onready var nav_2d : Navigation2D = get_node("..");
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
	_handle_special_move_1()


## HELPERS

func _handle_health():
	if (HEALTH <= 0):
		# DO ANIMATION
		# DIE
		var EXPLOSION_VFX : PackedScene = load("res://vfx/bossdeath/deathvfx.tscn");
		var vfx = EXPLOSION_VFX.instance();
		get_tree().get_root().add_child(vfx);
		vfx.position = self.global_position;
		vfx.set_as_toplevel(true);
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
			child.damage(DAMAGE);
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

# HANDLE SPECIAL MOVES

var STAMINA_1 : int = 0;

func _handle_special_move_1():
	
	if (STAMINA_1 == 300):
		STAMINA_1 = 0;
		set_process(false);
		# ANIMATE HERE
		animation.play("thrust")
		animation.speed_scale = 12;
		# DO MOVES
		var rng = RandomNumberGenerator.new()
		for x in range(5):
			rng.randomize()
			var rnumx = rng.randf_range(-300.0, 300.0)
			var rnumy = rng.randf_range(-300.0, 300.0)
			var temp = load("res://vfx/aoeboss/aoeboss.tscn").instance();
			add_child(temp);
			temp.set_as_toplevel(true);
			temp.global_position = global_position + Vector2(rnumx,rnumy);
			



		yield(get_tree().create_timer(1), "timeout");
		set_process(true);
	else:
		STAMINA_1 += 1;

