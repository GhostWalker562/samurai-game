extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var SPEED = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	_handle_movement();

	
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
