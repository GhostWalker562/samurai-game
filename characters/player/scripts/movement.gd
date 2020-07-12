extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var SPEED = 100;
export(int) var DASH_SPEED = 10;
export(int) var HEALTH = 100;



func _physics_process(_delta):
	_handle_movement();
	_handle_dash();
	_handle_aim();
	_handle_health();


	
# Handle Movement
func _handle_movement():
	var motion : Vector2 = Vector2();
	
	if (Input.is_action_pressed("movement_up")):
		motion.y -= SPEED;
	if (Input.is_action_pressed("movement_down")):
		motion.y += SPEED;
	if (Input.is_action_pressed("movement_right")):
		motion.x += SPEED;
	if (Input.is_action_pressed("movement_left")):
		motion.x -= SPEED;
	move_and_slide(motion);


func _handle_aim():
	var mouse_pos : Vector2 = get_local_mouse_position();
	# var sprite_pos : Vector2 = transform.get_origin();

	# self.rotation_degrees = sprite_pos.angle_to_point(mouse_pos)  + deg2rad(180);
	#print((mouse_pos.angle()+ deg2rad(-90)) * 0.25)
	rotation += (mouse_pos.angle()+ deg2rad(-90)) * 0.25;

## HANDLE HEALTH

func _handle_health():
	if (HEALTH <= 0):
		set_physics_process(false);
	pass

func damage(value:int):
	HEALTH-=value;

# HANDLE DASH
export(float) var MAX_STAMINA = 100;
export(float) var STAMINA = 100;
onready var stamina = get_node("Camera2D/GUI/Control")

func _handle_dash():
	_increment_stamina();
	if (STAMINA == MAX_STAMINA):
		var motion: Vector2 = Vector2();
		if (Input.is_action_just_pressed("movement_dash")):
			
			if (Input.is_action_pressed("movement_up")):
				motion.y -= SPEED;
			if (Input.is_action_pressed("movement_down")):
				motion.y += SPEED;
			if (Input.is_action_pressed("movement_right")):
				motion.x += SPEED;
			if (Input.is_action_pressed("movement_left")):
				motion.x -= SPEED;

			motion *= DASH_SPEED;
			STAMINA = 0;
			
		move_and_slide(motion);

		

func _increment_stamina():
	stamina.stamina_percent = STAMINA;
	if (STAMINA != MAX_STAMINA):
		STAMINA += 1;

