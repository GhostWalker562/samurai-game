extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var SPEED = 100;
export(int) var DASH_SPEED = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	_handle_movement();
	_handle_dash();
	_handle_aim();

	
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

func _handle_dash():
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
		
	move_and_slide(motion);

func _handle_aim():
	var mouse_pos : Vector2 = get_local_mouse_position();
	# var sprite_pos : Vector2 = transform.get_origin();

	# self.rotation_degrees = sprite_pos.angle_to_point(mouse_pos)  + deg2rad(180);
	rotation += (mouse_pos.angle()+ deg2rad(-90)) * 0.25;