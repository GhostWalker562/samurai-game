extends KinematicBody2D

onready var nav_2d : Navigation2D = get_node("..");

var player;
var path;

func _ready():
	player = get_node("../Player");

func _process(_delta):
	path = nav_2d.get_simple_path(self.global_position, player.global_position);
	move_along_path(5);

func move_along_path(distance:float):
	var start_point := position;
	for i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if (distance <= distance_to_next && distance >= 0.0):
			position = start_point.linear_interpolate(path[0],distance / distance_to_next);
			break
		elif (distance < 0.0):
			position = path[0];
			break
		distance -= distance_to_next;
		start_point = path[0];
		path.remove(0);
